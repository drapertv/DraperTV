class LivestreamsController < InheritedResources::Base

  before_filter :set_categories_and_colors, only: ["show", "index"]

  def show
    @livestream = Livestream.friendly.find(params[:id])
    @chapters = Chapter.all.limit(3)
    @popular = Series.popular
    @popular[2] = Chapter.all.sample
    @og_title = "#{@livestream.title} - DraperTV"
    @og_description = @livestream.description
    @meta_description = @livestream.description
    @og_image = @livestream.image_url
  end

  def index
    @og_title = "Livestreams - DraperTV "
    @og_description = "Livestreaming the best of Silicon Valley"
    @meta_description = "Watch live as top Silicon Valley speakers teach startup skills and entrepreneurship at Draper University. Be part of the action on DraperTV with live Q&A through @Draper_U on Twitter."
    @upcoming_livestreams = Livestream.upcoming.order('stream_date asc')
    @past_livestreams = Livestream.past.order('stream_date desc')
    @current_livestreams = Livestream.current
    @future_livestreams = @current_livestreams + @upcoming_livestreams

    indexes = (1..@future_livestreams.count).to_a.reject! {|n| n % 9 != 8}

    if indexes
      indexes.each do |i|
        chapter = Chapter.all.sample
        @future_livestreams = @future_livestreams.to_a.insert(i - 1, Chapter.all.sample)
      end
    end

    indexes = (1..@past_livestreams.count).to_a.reject! {|n| n % 9 != 8}
    if indexes
      indexes.each do |i|
        @past_livestreams = @past_livestreams.to_a.insert(i - 1, Chapter.all.sample)
      end
    end
    
    if !@current_livestreams.empty?
      @og_image = @current_livestreams.first.image_url
    elsif !@upcoming_livestreams.empty?
      @og_image = @upcoming_livestreams.first.image_url
    else
      @og_image = @past_livestreams.first.image_url
    end
  end

  def hidebanner
    session[:hidden_livestream_id] = Livestream.next_livestream.id
    render json: {hidden_id: Livestream.next_livestream.id}
  end

  private

   def set_categories_and_colors
    @categories = ["Attitude", "Starting Up", "Product", "Sales", "Marketing", "Fundraising", "Hiring", "Biz & Finance", "Legal", "Auxiliary"]
    @colors = ["blue", "cyan", "teal", "green", "yellow", "orange", "red", "purple", "black", "grey"]
  end



end