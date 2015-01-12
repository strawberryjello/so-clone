class Tag < ActiveRecord::Base

  has_and_belongs_to_many :questions
  

  validates_presence_of :name
  validates_uniqueness_of :name
  

  def self.parse_tag_string tag_string
    tags = []
    tag_strings = tag_string.split ','
    tag_strings.each do |t|
      old_tag = find_by(:name => t)
      if old_tag
        tags << old_tag
      else
        new_tag = new(:name => t)
        if new_tag.save
          tags << new_tag
        end
      end
    end
    return tags
  end
end
