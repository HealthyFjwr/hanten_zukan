# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_restaurant, only: %i[create update destroy]
  before_action :set_comment, only: %i[update destroy]

  def create
    @comment = Comment.new(restaurant: @restaurant, user: current_user, body: comment_params[:body])
    if @comment.save
      redirect_page(notice: 'コメントを投稿しました')
    else
      render 'restaurants/show'
    end
  end

  def update
    if @comment.update(body: comment_params[:body])
      redirect_page(notice: '更新しました')
    else
      render 'restaurants/show'
    end
  end

  def destroy
    @comment.destroy
    redirect_page
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def redirect_page(notice: nil)
    redirect_to restaurant_path(@restaurant), notice: notice
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
