class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_commentable

  def index
    @comments = @commentable.comments.order('created_at ASC')
  end

  def new
    @comment = @commentable.comments.new
  end

	# def show
	#   @article = Article.find(params[:id])
	#   @commentable = @article
	#   @comments = @commentable.comments
	#   @comment = Comment.new
	# end


	def create
	  @comment = @commentable.comments.new(comment_params)
	  @comment.user_id = current_user[:id]
    @user = User.find(@comment.user_id)

    if @comment.save

        respond_to do |format|
          format.html {  }
          format.js { @comment}
        end
	  else
	    render :new
	  end
	end

private


    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :user_id)
    end


  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)

  end

  # def load_commentable
  #   klass = [Article, Photo, Event].detect { |c| params["#{c.name.underscore}_id"] }
  #   @commentable = klass.find(params["#{klass.name.underscore}_id"])
  # end
end
