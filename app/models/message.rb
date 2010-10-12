class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  
  referenced_in :app, :inverse_of => :messages
  
  field :from
  field :to
  field :text
  field :redacted, :type => Boolean, :default => false
  field :sent, :type => DateTime
  
  set_callback(:save, :before) do |message|
    message.text = '' if message.redacted
  end
  
  validates_presence_of :from
  validates_associated :application
  validates_presence_of :to
  validates_presence_of :text
  validates_length_of :text, :within => 2..640
  validates_length_of :from, :within => 0..6, :if => Proc.new {|message| !!(message.from =~ /^\d+$/)} # Short code
  validates_length_of :from, :within => 0..16, :if => Proc.new {|message| !!(message.from =~ /^\+\d+$/)} # Msisdn, 16 digits including plus sign
  validates_length_of :from, :within => 0..11, :if => Proc.new {|message| !!(message.from =~ /^[0-9a-z]+$/)} # Alphanumeric
  validates_format_of :from, :with => /^[+a-z0-9æøå]{0,16}$/i
  validates_format_of :to, :with => /\+\d+/
  
end
