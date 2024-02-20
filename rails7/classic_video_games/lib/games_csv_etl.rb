require 'csv_parse_helpers'

require 'csv' # or 'fastercsv'
require 'set'
require 'stringio'

require File.expand_path('../../config/environment', __FILE__)


module GamesCSV

  class MissingHeadersError < StandardError; end

  class Loader
    include Enumerable

    MANDATORY_HEADERS = %i(name year manufacturer notes is_active)

    attr_reader :input, :options, :data

    def initialize(input, options=nil)
      @input = input
      @options = default_options
      options = @options || {}
      @csv = CSV.new(@input, **options)
      @checked_headers = false
    end

    def self.from_text(raw_csv, *the_rest)
      new(StringIO.new(raw_csv), *the_rest)
    end

    def default_options
      {
        headers: true,
        header_converters: :symbol,
        converters: [
          ->(v, info) { info.header != :is_active ? v
                        : ParseHelpers::IsActive.parse(v) },
          ->(v, info) { info.header != :year ? v
                        : v.to_i },
          ->(v, info) { info.header != :manufacturer ? v
                        : ParseHelpers::Manufacturers.parse(v) },
        ]
      }
    end

    def each
      @csv.each do |row|
        unless @checked_headers
          missing = MANDATORY_HEADERS.to_set - row.headers.to_set
          raise MissingHeadersError, missing.to_a.sort unless missing.empty?
          @checked_headers = true
        end
        yield Hash[row]
      end
    end

    def load_data
      return @data if @data
      @data = []
      each do |record|
        @data << record
      end
      @data
    end

  end


  class Normalizer

    attr_reader :record, :result

    KEEPERS = %i[name notes is_active].to_set

    def initialize(record)
      @record = record
    end

    def self.normalize_record(record)
      norm_res = record.select { |k, v| KEEPERS.include?(k) }
      norm_res[:publication_year] = record[:year]
      norm_res[:manufacturers] = record[:manufacturer].map { |manuf_rec|
        normalize_manufacturer_record(manuf_rec)
      }
      norm_res
    end

    def self.normalize_manufacturer_record(manuf_rec)
      norm_res = {company: manuf_rec[:manufacturer]}
      norm_res[:region] = manuf_rec[:region] unless manuf_rec[:region].nil?
      norm_res
    end

    def normalize_record(record)
      @result = self.class.normalize_record(record)
      @result
    end
  end


  class Importer
    attr_reader :record, :result

    def initialize(normalized_record, game_class=Game)
      @record = normalized_record
      @create_game = game_class
    end

    def self.import_record(record, game_class=Game)
      game = nil
      ActiveRecord::Base.transaction do
        base_attrs = record.reject { |k, v| k == :manufacturers }
        game = game_class.create!(base_attrs)
        game.manufacturers.create!(record[:manufacturers])
      end
      game
    end

    def import_record
      @result = self.class.import_record(record)
      @result
    end
  end
end
