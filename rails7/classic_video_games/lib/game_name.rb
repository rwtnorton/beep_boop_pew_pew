module GameName

  def self.normalize(name)
    name.strip
      .downcase
      .gsub(/\s+/, '_')
      .gsub(/\W+/, '')
      .gsub(/__+/, '_')
  end

end
