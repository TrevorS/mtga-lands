#!/usr/bin/env ruby

require "fileutils"
require "open-uri"

CARDS = [
  {id: 192, set: "RIX"},
  {id: 193, set: "RIX"},
  {id: 194, set: "RIX"},
  {id: 195, set: "RIX"},
  {id: 196, set: "RIX"},
  {id: 250, set: "DAR"},
  {id: 250, set: "WAR"},
  {id: 251, set: "DAR"},
  {id: 251, set: "WAR"},
  {id: 252, set: "DAR"},
  {id: 252, set: "WAR"},
  {id: 253, set: "DAR"},
  {id: 253, set: "WAR"},
  {id: 254, set: "DAR"},
  {id: 254, set: "WAR"},
  {id: 255, set: "DAR"},
  {id: 255, set: "WAR"},
  {id: 256, set: "DAR"},
  {id: 256, set: "WAR"},
  {id: 257, set: "DAR"},
  {id: 257, set: "WAR"},
  {id: 258, set: "DAR"},
  {id: 258, set: "WAR"},
  {id: 259, set: "DAR"},
  {id: 259, set: "WAR"},
  {id: 260, set: "DAR"},
  {id: 260, set: "GRN"},
  {id: 260, set: "RNA"},
  {id: 260, set: "WAR"},
  {id: 260, set: "XLN"},
  {id: 261, set: "DAR"},
  {id: 261, set: "GRN"},
  {id: 261, set: "M19"},
  {id: 261, set: "RNA"},
  {id: 261, set: "WAR"},
  {id: 261, set: "XLN"},
  {id: 262, set: "DAR"},
  {id: 262, set: "GRN"},
  {id: 262, set: "M19"},
  {id: 262, set: "RNA"},
  {id: 262, set: "WAR"},
  {id: 262, set: "XLN"},
  {id: 263, set: "DAR"},
  {id: 263, set: "GRN"},
  {id: 263, set: "M19"},
  {id: 263, set: "RNA"},
  {id: 263, set: "WAR"},
  {id: 263, set: "XLN"},
  {id: 264, set: "DAR"},
  {id: 264, set: "GRN"},
  {id: 264, set: "M19"},
  {id: 264, set: "RNA"},
  {id: 264, set: "WAR"},
  {id: 264, set: "XLN"},
  {id: 265, set: "DAR"},
  {id: 265, set: "M19"},
  {id: 265, set: "XLN"},
  {id: 266, set: "DAR"},
  {id: 266, set: "M19"},
  {id: 266, set: "XLN"},
  {id: 267, set: "DAR"},
  {id: 267, set: "M19"},
  {id: 267, set: "XLN"},
  {id: 268, set: "DAR"},
  {id: 268, set: "M19"},
  {id: 268, set: "XLN"},
  {id: 269, set: "DAR"},
  {id: 269, set: "M19"},
  {id: 269, set: "XLN"},
  {id: 270, set: "M19"},
  {id: 270, set: "XLN"},
  {id: 271, set: "M19"},
  {id: 271, set: "XLN"},
  {id: 272, set: "M19"},
  {id: 272, set: "XLN"},
  {id: 273, set: "M19"},
  {id: 273, set: "XLN"},
  {id: 274, set: "M19"},
  {id: 274, set: "XLN"},
  {id: 275, set: "M19"},
  {id: 275, set: "XLN"},
  {id: 276, set: "M19"},
  {id: 276, set: "XLN"},
  {id: 277, set: "M19"},
  {id: 277, set: "XLN"},
  {id: 278, set: "M19"},
  {id: 278, set: "XLN"},
  {id: 279, set: "M19"},
  {id: 279, set: "XLN"},
].freeze

def card_url(card)
  id = card[:id]
  card_set = card[:set]

  actual_card_set = (card_set == "DAR" ? "DOM" : card_set).downcase

  "https://www.mtgpics.com/pics/big/#{actual_card_set}/#{id}.jpg"
end

def card_path(card)
  "./images/#{card[:set]}/#{card[:id]}.jpg"
end

CARDS.map { |c| c[:set] }.uniq.each do |card_set|
  FileUtils.mkdir_p "./images/#{card_set}"
end

CARDS.each do |card|
  url = card_url(card)
  path = card_path(card)

  if File.exists?(path)
    puts "Already downloaded: #{url}"
    next
  end

  puts "Downloading: #{url} to #{path}"

  begin
    download = URI.open(url)
    IO.copy_stream(download, path)
  rescue OpenURI::HTTPError
    puts "Could not find #{url}!"
  end
end
