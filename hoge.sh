#!/bin/sh

# birthday -> gradeの推移性があるが、とりあえず無視してDBを作る。

# bundle exec rails destroy model card id:integer name:string number:string skill:string
# bundle exec rails destroy model member id:integer rarerity:integer birthday:string grade:string piece1:string piece2:string piece3:string piece4:string bonus:string ability:string costume:string
# bundle exec rails destroy model music id:integer color:string live_p_base:integer live_p_extra integer score_red:integer score_green:integer score_blue:integer score_common:integer
# 
# bundle exec rails generate model card card_id:integer name:string number:string skill:string
# bundle exec rails generate model member card_id:integer rarerity:integer birthday:string grade:string piece1:string piece2:string piece3:string piece4:string bonus:string ability:string costume:string
# bundle exec rails generate model music card_id:integer color:string live_p_base:integer live_p_extra integer score_red:integer score_green:integer score_blue:integer score_common:integer
# 
# bundle exec rails generate model deck deck_id:integer memberlist_id:integer setlist_id:integer
# bundle exec rails generate model memberlist memberlist_id:integer number:string count:integer
# bundle exec rails generate model setlist memberlist_id:integer number:string count:integer
bundle exec rails generate scaffold_controller deck
