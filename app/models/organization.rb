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
    #Build a string for the pretty display of stats.
    pretty_stats = "<table>"
    pretty_stats += '<tr><td>Manpower</td><td>' + "<img src=\"/images/stat_#{self.manpower}.png\"" + "/>" + '</td></tr>'
    pretty_stats += '<tr><td>Specialists</td><td>' + "<img src=\"/images/stat_#{self.specialists}.png\"" + "/>" + '</td></tr>'
    pretty_stats += '<tr><td>Transportation</td><td>' + "<img src=\"/images/stat_#{self.transportation}.png\"" + "/>" + '</td></tr>'
    pretty_stats += '<tr><td>Internal Security</td><td>' + "<img src=\"/images/stat_#{self.internal_security}.png\"" + "/>" + '</td></tr>'
    pretty_stats += '<tr><td>Firepower</td><td>' + "<img src=\"/images/stat_#{self.firepower}.png\"" + "/>" + '</td></tr>'
    pretty_stats += '<tr><td>Knowledge</td><td>' + "<img src=\"/images/stat_#{self.knowledge}.png\"" + "/>" + '</td></tr>'
    pretty_stats += '<tr><td>Publicity</td><td>' + "<img src=\"/images/stat_#{self.publicity}.png\"" + "/>" + '</td></tr>'
    pretty_stats += '<tr><td>Public Relations</td><td>' + "<img src=\"/images/stat_#{self.public_relations}.png\"" + "/>" + '</td></tr>'
    pretty_stats += '<tr><td>Intrusion</td><td>' + "<img src=\"/images/stat_#{self.intrusion}.png\"" + "/>" + '</td></tr>'
    pretty_stats += '<tr><td>Slush Funds</td><td>' + "<img src=\"/images/stat_#{self.slush_funds}.png\"" + "/>" + '</td></tr>'
    pretty_stats += '<tr><td>Bases</td><td>' + "<img src=\"/images/stat_#{self.bases}.png\"" + "/>" + '</td></tr>'
    pretty_stats += '<tr><td>Bureaucracy</td><td>' + "<img src=\"/images/stat_#{self.bureaucracy}.png\"" + "/>" + '</td></tr>'
    pretty_stats += '</table>'
    return pretty_stats
  end
end
