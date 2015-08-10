url = "http://courses.drapertv.com/tracks"

response = HTTParty.get(url)


Chapter.destroy_all


response["chapters"].each do |chapter|
	chapter = Chapter.create chapter_type: "", summary: chapter["track"]["summary"], name: chapter["track"]["name"], chapter_uid: chapter["track"]["id"], topic_uid: chapter["topic_id"], topic_name: chapter["topic_name"], lessons_info: chapter["lesson_info"], description: chapter["track"]["description"]
	p chapter.chapter_uid
end

["Attitude", "Starting Up", "Product", "Sales", "Marketing", "Fundraising", "Hiring", "Biz & Finance", "Legal", "Auxiliary"].each do |cat|
	Chapter.where(topic_name: cat.upcase).order(:id).each_with_index do |c, i|
		c.update_attributes number: i + 1
	end
end