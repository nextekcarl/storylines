class Organization < ActiveRecord::Base
  acts_as_tree :order => "name"

  belongs_to :creator, :class_name => "User", :foreign_key => :created_by
  belongs_to :modifier, :class_name => "User", :foreign_key => :modified_by
  belongs_to :universe
  has_and_belongs_to_many :characters

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false, :scope => :universe_id

  validates_inclusion_of :manpower, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :specialists, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :transportation, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :internal_security, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :firepower, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :knowledge, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :publicity, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :public_relations, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :intrusion, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :slush_funds, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :bases, :in => 0..10, :message => 'must be between 0 and 10'
  validates_inclusion_of :bureaucracy, :in => 0..10, :message => 'must be between 0 and 10'

  def my_stats
    #Creating a hash so we can build a string for the pretty display of stats.
    stats = Hash.new
    pretty_stats = "<table>"
    stats[:manpower]=self.manpower
    stats[:specialists]=self.specialists
    stats[:transportation]=self.transportation
    stats[:internal_security]=self.internal_security
    stats[:firepower]=self.firepower
    stats[:knowledge]=self.knowledge
    stats[:publicity]=self.publicity
    stats[:public_relations]=self.public_relations
    stats[:intrusion]=self.intrusion
    stats[:slush_funds]=self.slush_funds
    stats[:bases]=self.bases
    stats[:bureaucracy]=self.bureaucracy
    stats.each{|name, value| pretty_stats += '<tr><td>' + h(name.to_s.humanize) + '</td><td>' + "<img src=\"images/stat_#{value}.png\"" + "/>" + '</td></tr>'}
    pretty_stats += '</table>'
    return pretty_stats
  end
end
