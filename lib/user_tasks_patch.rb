require 'user'

module UserTasksPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      has_many :tasks
    end
  end
  
  module InstanceMethods
    def tasks_top_menu
      self.tasks.count > 0 ? "Todo List (#{self.tasks.count})" : "Todo List"
    end
  end
end