class App
  include Mongoid::Document
  include Mongoid::Timestamps
  
  references_many :messages
  
  field :name
  field :url
  field :apikey
  
  validates_presence_of :name
  validates_presence_of :apikey
  validates_length_of :apikey, :is => 40
  validates_format_of :apikey, :with => /^[0-9a-f]+$/
  validates_uniqueness_of :apikey
  # validates_uniqueness_of :url# Leave off for now, in case an app wants to use several urls for some reason
  validates_format_of :url, :with => URI::regexp(%W(http https))
  
end
