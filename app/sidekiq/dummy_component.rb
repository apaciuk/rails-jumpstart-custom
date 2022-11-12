require 'sidekiq-scheduler'
require 'json'
require 'logger'

class DummyComponent
  include Sidekiq::Worker

  def perform
    
  end
  
end