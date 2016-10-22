require 'spec_helper'
require 'game_image_finder'

require 'tmpdir'
require 'fileutils'

verbose = false

def clear_dir(dir, verbose)
  files = Dir.glob(File.join(dir, '*'))
  FileUtils.rm_f(files, verbose: verbose) unless files.empty?
end

## Set up test directory just once; teardown at the end.
# Dir.mktmpdir('imgs') do |dir|
begin
  dir = Dir.mktmpdir('imgs')

  describe GameImageFinder do

    it "should create an instance given valid attributes" do
      o = GameImageFinder.new('blarg', dir)
      expect(o).to_not be_nil
    end

    it "should have a game_name attr" do
      o = GameImageFinder.new('blarg', dir)
      expect(o).to respond_to(:game_name)
      expect(o.game_name).to eq('blarg')
    end

    context "given the game image file is missing in empty dir" do
      before(:each) { clear_dir(dir, verbose) }

      let(:finder) { GameImageFinder.new('not_there', dir) }

      it "#image_name should return nil" do
        expect(finder.image_name).to be_nil
      end
    end

    context "given the game image file is present in dir" do
      before(:each) do
        clear_dir(dir, verbose)
        FileUtils.touch(File.join(dir, 'awesome_game.png'), verbose: verbose)
      end

      let(:finder) { GameImageFinder.new('awesome_game', dir) }

      it "#image_name should find the image file name" do
        expect(finder.image_name).to eq('awesome_game.png')
      end

      it "#image_name should find the normalized file name" do
        fnd = GameImageFinder.new('AWESOME-Game!!!', dir)
        expect(finder.image_name).to eq('awesome_game.png')
      end
    end

    context "given the game image file is missing in non-empty dir" do
      before(:each) do
        clear_dir(dir, verbose)
        FileUtils.touch(File.join(dir, 'trogdor.gif'), verbose: verbose)
      end
      let(:finder) { GameImageFinder.new('awesome_game', dir) }

      it "#image_name should return nil" do
        expect(finder.image_name).to be_nil
      end
    end
  end
ensure
  END { FileUtils.rm_rf(dir, verbose: verbose) }
end
