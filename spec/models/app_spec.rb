require 'spec_helper'

module AppSpecHelper
  def valid_attributes
    {
      :name => 'Budstikka bildebestilling',
      :url => 'http://bildebestilling.budstikka.no',
      :apikey => '008f3f0c4407e809ca2b87bc8c83f97beb1d6cec'
    }
  end 
end


describe App do

  include AppSpecHelper
  
  before(:each) do
    @app = App.new
  end
  
  it 'should have a name' do
    @app.attributes = valid_attributes.except(:name)
    @app.should_not be_valid
    
    @app.name = ''
    @app.should_not be_valid
  end
  
  
  it 'should require a valid url, either http or https' do
    @app.attributes = valid_attributes
    @app.should be_valid
    
    @app.url = ''
    @app.should_not be_valid
    
    @app.url = 'ftp://ftp.budstikka.no'
    @app.should_not be_valid    
  end

  describe 'should have an apikey that' do
    it 'should be 40 characters logs' do
      @app.attributes = valid_attributes
      @app.should be_valid
      
      @app.apikey = 'abc123'
      @app.should_not be_valid
    end
    it 'should be a hexdigest' do
      @app.attributes = valid_attributes
      @app.should be_valid
      
      @app.apikey = 'abcde'*7
      @app.apikey += 'abcdg'
      @app.should_not be_valid
      
    end
    it 'should be unique'
  end
  
end
