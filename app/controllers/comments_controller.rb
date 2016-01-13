class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :edit, :destroy]
  before_action :author!, only: [:edit, :update, :destroy]

  expose(:comment)

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @recipe, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def author!
      if current_user.nil?
        redirect_to new_user_session_path
      else
        unless @comment.user_id == current_user.id || current_user.admin?
          redirect_to :back, notice: "You are not allowed to make changes"
        end
      end
    end

    def comment_params
      params.require(:comment).permit(:recipe_id, :body, :user_id, :rating)
    end
end
