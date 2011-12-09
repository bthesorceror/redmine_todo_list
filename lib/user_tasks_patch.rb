require 'user'

module UserTasksPatch
  def self.included(base)
    base.class_eval do
      unloadable
      has_many :tasks
    end
  end
end