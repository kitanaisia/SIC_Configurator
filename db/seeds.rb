# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Card.delete_all
Member.delete_all
Music.delete_all

character = open("db/member.csv").read.split("\n").collect{|row| row.split("\t")} 
character.each do |row|
  rarity = 0
  if row[5] == "☆☆☆"
    rarity = 3
  elsif row[5] == "☆☆"
    rarity = 2
  elsif row[5] == "☆"
    rarity = 1
  end
  Card.create({ name: row[0],
                number: row[1],
                card_id: row[2],
                skill: row[3],
                img: row[4]
  })
  Member.create({ number: row[1], 
                  rarity: rarity,
                  birthday: row[6], 
                  piece1: row[7], 
                  piece2: row[8], 
                  piece3: row[9], 
                  piece4: row[10], 
                  bonus: row[11], 
                  ability: row[12], 
                  costume: row[13]
  })
end

music = open("db/music.csv").read.split("\n").collect{|row| row.split("\t")} 
music.each do |row|
  live_p = row[6]
  live_p_base = nil
  live_p_extra = "-"
  # 追加得点がある楽曲の場合
  if live_p =~ /(\d)+\+(.*?)/
    live_p_base = $1.to_i
    live_p_base = $2
  else
    live_p_base = live_p.to_i
  end

  Card.create({ name: row[0],
                number: row[1],
                card_id: row[2],
                skill: row[3],
                img: row[4]
  })
  Music.create({ number: row[1],
                 color: row[5],
                 live_p_base: live_p_base,
                 live_p_extra: live_p_extra,
                 score_red: row[7],
                 score_green: row[8],
                 score_blue: row[9],
                 score_common: row[10]     
  })
end

