class Tag < ActiveRecord::Base

  has_and_belongs_to_many :questions
  

  validates_presence_of :name

  def self.parse_tag_string tag_string
    tags = nil
    # split along whitespace
    tags = tag_string.split
    # validate or save?
  end
end
