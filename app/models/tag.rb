class Tag < ActiveRecord::Base

  has_and_belongs_to_many :questions
  

  validates_presence_of :name

  def self.parse_tag_string tag_string
    tags = []
    # split along whitespace
    tag_strings = tag_string.split
    tag_strings.each do |t|
      new_tag = new(:name => t)
      # check if tag already exists
      if new_tag.save
        tags << new_tag
      end
    end
    return tags
  end
end
