class Task < ActiveRecord::Base
  unloadable
  
  validates_presence_of :body, :message => "cannot be blank"
  
  def to_s
    self.body
  end
  
end
