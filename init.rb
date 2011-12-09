require 'redmine'

require 'dispatcher'
require 'user_tasks_patch'
require 'principal_patch'

Dispatcher.to_prepare do
  Principal.send(:include, PrincipalPatch) unless Principal.included_modules.include? PrincipalPatch
  User.send(:include, UserTasksPatch) unless User.included_modules.include? UserTasksPatch
end

Redmine::Plugin.register :redmine_user_status do
  name 'Redmine Task List plugin'
  author 'Brandon Farmer and Josh Thomas'
  description 'Allows you to maintain a personal todo list'
  version '0.0.1'

  menu :top_menu, :todo_list, 
    {:controller => 'tasks', :action => 'index'}, 
    :caption => Proc.new {User.current.tasks_top_menu}, 
    :if => Proc.new { User.current.logged? }
end
