require 'spec_helper'

module MessageSpecHelper
  def valid_attributes
    {
      :from => 'Peter',
      :to => '+4798817739',
      :text => 'This is a text'
    }
  end 
end

describe Message do
  
  include MessageSpecHelper
  
  before(:each) do
    @message = Message.new
  end
  
  it 'should be valid' do
    @message.attributes = valid_attributes
    @message.should be_valid
  end
  
  it 'should require text to be atleast 2 characters, and no more than 640 characters' do
    @message.attributes = valid_attributes.except(:text)
    @message.should_not be_valid
    
    @message.text = 'a'
    @message.should_not be_valid
    
    @message.text = 'ok'
    @message.should be_valid
    
    @message.text = 'a'*640
    @message.should be_valid
    
    @message.text += 'b'
    @message.should_not be_valid
  end
  
  it 'should not allow sender to be more than 16 characters including prefix' do
    @message.attributes = valid_attributes.except(:from)
    @message.from = "+47#{'1'*13}"
    @message.should be_valid
    @message.from += '2'
    @message.should_not be_valid
  end
  
  it 'should only allow alphanumeric sender length from 1 up to 11 characters' do
    @message.attributes = valid_attributes.except(:from)
    
    @message.from = 'a'
    @message.should be_valid
    
    @message.from = 'a'*11
    @message.should be_valid
    
    @message.from += 'b'
    @message.should_not be_valid
  end
  
  it 'should require sender' do
    @message.attributes = valid_attributes.except(:from)
    @message.should_not be_valid
  end
  
  it 'should only allow short codes between 0 and 6 characters' do
    @message.attributes = valid_attributes.except(:from)
    
    @message.from = '0'
    @message.should be_valid
    
    @message.from = '0'*7
    @message.should_not be_valid
  end
  
  it 'should only allow sending to a valid msisdn' do
    @message.attributes = valid_attributes.except(:to)
    
    @message.to = '98817739'
    @message.should_not be_valid
    
    @message.to = '+356123456789'
    @message.should be_valid
  end
  
end
