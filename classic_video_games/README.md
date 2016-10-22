# Classic Video Game Gallery

Rails-based gallery of classic video games.

## Setup

After cloning repo:
```sh
  $ cd path/to/cloned/repo
  ## Install dependencies
  $ bundle install
  ## Start a Rails server
  $ bundle exec rails s
```
Beyond that, you will also need to install the game image files and
import the game data from a CSV file (as showm below).

## Installing game image files

To install game image files, run:
```sh
  $ script/install_game_image ../game_images/*
  ### or with --debug for more info
  $ script/install_game_image --debug ../game_images/*
```

## Importing game CSV file

To load game data from a CSV file into the app db, run:
```sh
  ## Note: db will be reset (table drops and schema re-migrated)!!!
  $ bundle exec rake csv:import:games path/to/your/games.csv
  ## Compatible with normal use of RAILS_ENV
  $ RAILS_ENV=production bundle exec rake csv:import:games rad_genesis.csv
```
