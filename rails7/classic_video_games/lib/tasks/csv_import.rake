namespace :csv do
  namespace :import do
    desc "Imports CSV file into games table; requires arg csv_file_path"
    task games: :environment do
      # ARGV[0] is the task name
      abort "Missing required argument: path/to/csv_file" if ARGV.size <= 1
      csv_file = ARGV[1]
      abort "File does not exist: #{csv_file}" unless File.exist?(csv_file)
      abort "File not readable: #{csv_file}" unless File.readable?(csv_file)
      Rake::Task['db:reset'].invoke
      cmd = %q[bin/import_games_csv %s] % csv_file
      system(cmd) or abort "Unable to run %p: #$?" % cmd
    end
  end
end
