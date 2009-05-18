class CharactersController < ApplicationController
  active_scaffold :character do |config|
    #config.label = "Characters"
    config.columns = [:name, :age, :height, :weight, :strength, :cunning, :agility, :charisma, :endurance, :description, :history, :experiences, :events]
    config.show.link.inline = false
    config.subform.layout = :vertical
    #config.subform.layout = :vertical
    #config.nested.add_link(“Events”, [:events])
    #list.columns.exclude :comments
    #list.sorting = {:name => 'ASC'}
    #columns[:phone].label = "Phone #"
    #columns[:phone].description = "(Format: ###-###-####)"
  end
end
