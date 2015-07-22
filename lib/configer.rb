require 'active_record'
require 'yaml'

class Configer

  attr_accessor :db_setts

  def initialize
    @db_setts = YAML::load(File.open("config/database.yml"))
  end

  def connect
    ActiveRecord::Base.establish_connection(@db_setts)
  end
end
