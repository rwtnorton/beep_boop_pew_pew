module ParseHelpers
  module IsActive
    def self.parse(s)
      not (s =~ /^(?:1|y|yes|t|true)$/i).nil?
    end
  end

  module Regions
    def self.normalize(s)
      return '' if s.nil?
      region = s.strip
      case region.downcase
      when 'us', 'u.s.'
        'US'
      when 'japan'
        'JP'
      when 'north america'
        'NA'
      else
        region
      end
    end
  end

  module Manufacturers
    def self.with_region(s)
      return {} if s.nil?
      matches = s.match /^\s* ([\w\s-]+?) (?:\s+ \(\s* (.+) \s*\) )?\s*$/x
      return {manufacturer: s, region: ''} unless matches
      {manufacturer: matches[1], region: Regions.normalize(matches[2])}
    end

    def self.parse(s)
      return [] unless s
      s.to_s.split(%r{\s*/\s*}).map { |v| with_region(v) }
    end
  end
end
