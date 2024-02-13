require 'spec_helper'
require 'csv_parse_helpers'

describe ParseHelpers::Regions do
  context '#normalize' do
    [
      [nil, ''],
      ['US', 'US'],
      ['U.S.', 'US'],
      ['   u.s.  ', 'US'],
      ['Japan', 'JP'],
      ['North America', 'NA'],
      ['', ''],
      ['Dunno???', 'Dunno???'],
    ].each do |v, expected|
      it 'maps %p to %p' % [v, expected] do
        got = ParseHelpers::Regions.normalize(v)
        expect(got).to eq(expected)
      end
    end
  end
end

describe ParseHelpers::IsActive do
  context '#parse' do
    [
      [nil, false],
      ['1', true],
      ['0', false],
      ['y', true],
      ['Y', true],
      ['yes', true],
      ['YES', true],
      ['t', true],
      ['T', true],
      ['true', true],
      ['TRUE', true],
      ['false', false],
      ['f', false],
      ['n', false],
      ['nope', false],
      ['nadda', false],
      ['negative', false],
      ['', false],
    ].each do |v, expected|
      it 'maps %p to %p' % [v, expected] do
        got = ParseHelpers::IsActive.parse(v)
        expect(got).to eq(expected)
      end
    end
  end
end

describe ParseHelpers::Manufacturers do
  context '#with_regions' do
    [
      [nil, {}],
      ['', {manufacturer: '', region: ''}],
      ['Namco', {manufacturer: 'Namco', region: ''}],
      ['Namco (Japan)', {manufacturer: 'Namco', region: 'JP'}],
      ['Stern (North America)', {manufacturer: 'Stern', region: 'NA'}],
      ['Amstar Electronics', {manufacturer: 'Amstar Electronics', region: ''}],
      ['Sega-Gremlin (North America)', {manufacturer: 'Sega-Gremlin',
                                        region: 'NA'}],
      ['Williams Electronics (U.S.)', {manufacturer: 'Williams Electronics',
                                       region: 'US'}],
    ].each do |v, expected|
      it 'maps %p to %p' % [v, expected] do
        got = ParseHelpers::Manufacturers.with_region(v)
        expect(got).to eq(expected)
      end
    end
  end

  context '#parse' do
    [
      ['Data East (Japan) / Bally Midway (US)',
       [{manufacturer: 'Data East', region: 'JP'},
        {manufacturer: 'Bally Midway', region: 'US'}]],
      ['Amstar Electronics / Centuri (U.S.) / Taito (Japan)',
       [{manufacturer: 'Amstar Electronics', region: ''},
        {manufacturer: 'Centuri', region: 'US'},
        {manufacturer: 'Taito', region: 'JP'}]],
      ['', []],
      [nil, []],
    ].each do |v, expected|
      it 'maps %p to %p' % [v, expected] do
        got = ParseHelpers::Manufacturers.parse(v)
        expect(got).to eq(expected)
      end
    end
  end
end
