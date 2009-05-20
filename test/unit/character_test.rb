require 'test_helper'

class CharacterTest < ActiveSupport::TestCase

  test "should be able to save a new character" do
    @character = Character.new(:name => "Newbie", :age => 1, :height => "6'0",
    :weight => "180 lbs", :strength => 1, :cunning => 2, :agility => 3,
    :charisma => 4, :endurance => 5, :description => "He is tall.",
    :history => "He lived, he died.")
    assert @character.save
    @newest_character = Character.find(:last)
    assert_equal "Newbie", @newest_character.name
  end

  test "should not be able to save a new character with non-unique name" do
    @character = Character.new(:name => "Newbie", :age => 1, :height => "6'0",
    :weight => "180 lbs", :strength => 1, :cunning => 2, :agility => 3,
    :charisma => 4, :endurance => 5, :description => "He is tall.",
    :history => "He lived, he died.")
    assert @character.valid?
    assert @character.save
    @character2 = Character.new(:name => "Newbie", :age => 1, :height => "5'0",
    :weight => "150 lbs", :strength => 1, :cunning => 2, :agility => 3,
    :charisma => 4, :endurance => 5, :description => "He is short.",
    :history => "He was born.")
    assert !@character2.save
  end

  test "should require all stats to save a new character" do
    @character = Character.new(:name => "Newbie", :age => 1, :height => "6'0",
    :weight => "180 lbs", :description => "He is tall.",
    :history => "He lived, he died.")
    assert !@character.valid?
    assert @character.errors.invalid?(:strength)
    assert @character.errors.invalid?(:cunning)
    assert @character.errors.invalid?(:agility)
    assert @character.errors.invalid?(:endurance)
    assert @character.errors.invalid?(:charisma)
  end

  test "should not be able to save a new character with invalid stats" do
    @character = Character.new(:name => "Newbie", :age => 1, :height => "6'0",
    :weight => "180 lbs", :strength => -1, :cunning => 11, :agility => 12,
    :charisma => 14, :endurance => 15, :description => "He is tall.",
    :history => "He lived, he died.")
    assert !@character.valid?
    assert @character.errors.invalid?(:strength)
    assert @character.errors.invalid?(:cunning)
    assert @character.errors.invalid?(:agility)
    assert @character.errors.invalid?(:endurance)
    assert @character.errors.invalid?(:charisma)
  end
end
