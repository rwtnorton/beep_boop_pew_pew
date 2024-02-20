require 'spec_helper'
require 'games_csv_etl'
require 'model_fakes'

VALID_CSV_TEXT = <<'END_CSV'
name,year,manufacturer,notes,is_active
1942,1984,Capcom,Capcom's first hit game,1
Vanguard,1981,SNK (Japan) / Centuri (US),"Early scrolling shooter that scrolls in multiple directions, and allows shooting in four directions, using four direction buttons, similar to dual-stick controls.",0
END_CSV

MISSING_HEADERS_CSV_TEXT = <<'END_CSV'
name,year
1942,1984
Vanguard,1981
END_CSV


describe GamesCSV::Loader do

  it "should load valid CSV into expected form" do
    loader = GamesCSV::Loader.from_text(VALID_CSV_TEXT)
    loader.load_data
    expected = [
      {name: '1942',
       year: 1984,
       manufacturer: [{manufacturer: 'Capcom', region: ''}],
       notes: %q(Capcom's first hit game),
       is_active: true},
      {name: 'Vanguard',
       year: 1981,
       manufacturer: [{manufacturer: 'SNK', region: 'JP'},
                      {manufacturer: 'Centuri', region: 'US'}],
       notes: %q(Early scrolling shooter that scrolls in multiple directions, and allows shooting in four directions, using four direction buttons, similar to dual-stick controls.),
       is_active: false},
    ]
    expect(loader.data).to eq(expected)
  end

  it "should raise error when missing mandatory headers" do
    expect {
      csv = GamesCSV::Loader.from_text(MISSING_HEADERS_CSV_TEXT)
      csv.load_data
    }.to raise_error(GamesCSV::MissingHeadersError)
  end
end


describe GamesCSV::Normalizer do
  describe "should normalize Importer records" do
    [
      [
       {name: '1942',
        year: 1984,
        manufacturer: [{manufacturer: 'Capcom', region: ''}],
        notes: %q(Capcom's first hit game),
        is_active: true},
       {name: '1942',
        publication_year: 1984,
        manufacturers: [{company: 'Capcom', region: ''}],
        notes: %q(Capcom's first hit game),
        is_active: true}],
      [{name: 'Vanguard',
        year: 1981,
        manufacturer: [{manufacturer: 'SNK', region: 'JP'},
                       {manufacturer: 'Centuri', region: 'US'}],
        notes: %q(Early scrolling shooter that scrolls in multiple directions, and allows shooting in four directions, using four direction buttons, similar to dual-stick controls.),
        is_active: false},
       {name: 'Vanguard',
        publication_year: 1981,
        manufacturers: [{company: 'SNK', region: 'JP'},
                        {company: 'Centuri', region: 'US'}],
        notes: %q(Early scrolling shooter that scrolls in multiple directions, and allows shooting in four directions, using four direction buttons, similar to dual-stick controls.),
        is_active: false}],
    ].each do |rec, expected|
      # NOTE: assumes :name is unique in each test case above.
      it "normalizes record %s correctly" % rec[:name] do
        expect(
          GamesCSV::Normalizer.normalize_record(rec)
        ).to eq(expected)
      end
    end
  end
end


describe GamesCSV::Importer do
  it "should import normalized records" do
    rec = {name: 'Vanguard',
           publication_year: 1981,
           manufacturers: [{company: 'SNK', region: 'JP'},
                           {company: 'Centuri', region: 'US'}],
           notes: %q(Early scrolling shooter that scrolls in multiple directions, and allows shooting in four directions, using four direction buttons, similar to dual-stick controls.),
           is_active: false}
    game = GamesCSV::Importer.import_record(rec, Fake::Game)
    expect(game).to_not be_nil
    expect(game.name).to eq(rec[:name])
    expect(game.publication_year).to eq(rec[:publication_year])
    expect(game.notes).to eq(rec[:notes])
    expect(game.is_active).to eq(rec[:is_active])
    expect(game.manufacturers.count).to eq(rec[:manufacturers].size)
    expect(
      game.manufacturers[0].company
    ).to eq(rec[:manufacturers][0][:company])
    expect(
      game.manufacturers[0].region
    ).to eq(rec[:manufacturers][0][:region])
    expect(
      game.manufacturers[1].company
    ).to eq(rec[:manufacturers][1][:company])
    expect(
      game.manufacturers[1].region
    ).to eq(rec[:manufacturers][1][:region])
  end
end
