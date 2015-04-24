class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_commentable

  def index
    @comments = @commentable.comments.order('created_at ASC')
  end

	def create
	  render nothing: true and return if !current_user 
    
    @comment = @commentable.comments.new(comment_params)
	  @comment.user_id = current_user[:id]
    @user = User.find(@comment.user_id)

    if @comment.save
        if @comment.is_root?
          render partial: 'comment', locals: {comment: @comment} and return
        else
          render partial: 'nested_comment', locals: {comment: @comment} and return
        end
	  else
	    render nothing: true
	  end
	end

private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :parent_id, :parent, :video_url)
    end

  def load_commentable
    resource, id = request.path.split('/')[-3..-2]
    @commentable = resource.singularize.classify.constantize.find(id)

  end
end
