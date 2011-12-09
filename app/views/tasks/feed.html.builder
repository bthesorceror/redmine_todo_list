xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Your Tasks"
    xml.description "Lots of Tasks"
    xml.link url_for(:action => :index, :only_path => false)
    
    for task in @tasks
      xml.item do
        xml.title "Mark Task As Complete"
        xml.description task.body
        xml.pubDate task.created_at.to_s(:rfc822)
        xml.link url_for(:action => :destroy, :id => task.id, :only_path => false)
        xml.guid task.id
      end
    end
  end
end