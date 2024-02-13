require 'spec_helper'
require 'game_name'

describe GameName do
  context "#normalize" do
    [
      ["1942", "1942"],
      ["Asteroids", "asteroids"],
      ["Battlezone", "battlezone"],
      ["Berzerk", "berzerk"],
      ["BurgerTime", "burgertime"],
      ["Centipede", "centipede"],
      ["Defender", "defender"],
      ["Dig Dug", "dig_dug"],
      ["Donkey Kong", "donkey_kong"],
      ["Donkey Kong Junior", "donkey_kong_junior"],
      ["Dragon's Lair", "dragons_lair"],
      ["Elevator Action", "elevator_action"],
      ["Frogger", "frogger"],
      ["Galaga", "galaga"],
      ["Galaxian", "galaxian"],
      ["Gorf", "gorf"],
      ["Gravitar", "gravitar"],
      ["Gyruss", "gyruss"],
      ["Joust", "joust"],
      ["Jungle King", "jungle_king"],
      ["Lunar Lander", "lunar_lander"],
      ["Mappy", "mappy"],
      ["Mario Bros.", "mario_bros"],
      ["Missile Command", "missile_command"],
      ["Moon Patrol", "moon_patrol"],
      ["Ms. Pac-Man", "ms_pacman"],
      ["Pac-Man", "pacman"],
      ["Paperboy", "paperboy"],
      ["Pengo", "pengo"],
      ["Phoenix", "phoenix"],
      ["Pole Position", "pole_position"],
      ["Punch-Out!!", "punchout"],
      ["Q*bert", "qbert"],
      ["Qix", "qix"],
      ["Rally-X", "rallyx"],
      ["Robotron 2084", "robotron_2084"],
      ["Scramble", "scramble"],
      ["Space Invaders", "space_invaders"],
      ["Spy Hunter", "spy_hunter"],
      ["Star Castle", "star_castle"],
      ["Star Trek", "star_trek"],
      ["Star Wars", "star_wars"],
      ["Tapper", "tapper"],
      ["Tempest", "tempest"],
      ["Time Pilot", "time_pilot"],
      ["Track & Field", "track_field"],
      ["Tron", "tron"],
      ["Vanguard", "vanguard"],
      ["Wizard of Wor", "wizard_of_wor"],
      ["Xevious", "xevious"],
      ["Zaxxon", "zaxxon"],
    ].each do |name, expected|
      it "maps '#{name}' to '#{expected}'" do
        got = GameName.normalize(name)
        expect(got).to eq(expected)
      end
    end
  end
end
