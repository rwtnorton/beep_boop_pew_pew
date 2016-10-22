require "rails_helper"

describe GameMailer do
  let!(:game) do
    # TODO: fixture or factory would be better here
    g = Game.create!(name: 'Pong',
                     publication_year: 1972,
                     is_active: true)
    g.manufacturers.create!([{company: 'Atari'},
                             {company: 'Foo', region: 'US'}])
    g.likes.create!([{ip_addr: '10.0.1.1'}, {ip_addr: '10.0.1.2'}])
    g
  end
  let(:like) { game.likes.last }

  context "#liked_email" do
    let(:email) { GameMailer.liked_email(like) }

    it "renders the headers" do
      expect(email.subject).to eq('Game "Pong" was liked!')
      expect(email.to).to eq([Rails.application.config.liked_email_recipient])
      expect(email.from).to eq(['from@example.com'])
    end

    it "renders the body" do
      expect(email.body.encoded).to match(/\bPong\b/)
      expect(email.body.encoded).to match(/\b1972\b/)
      expect(email.body.encoded).to match(/\bAtari\b/)
      expect(email.body.encoded).to match(/\bFoo\b.*\bUS\b/)
      expect(email.body.encoded).to match(/\b10\.0\.1\.2\b/)
      expect(email.body.encoded).to match(/\b2\s+likes\b/)
    end
  end
end
