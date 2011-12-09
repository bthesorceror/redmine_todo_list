class Task < ActiveRecord::Base
  unloadable
  
  def to_s
    self.body
  end
  
end
