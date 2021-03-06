# frozen_string_literal: true

class CommentsController < ApplicationController
  include Paginable

  skip_before_action :authorize!, only: [:index]
  before_action :load_article

  def index
    # comments = @article.comments.
    #   page(params[:page]).
    #   per(params[:per_page])
    paginated = paginate(@article.comments)
    render_collection(paginated)
  end

  def create
    @comment = @article.comments.build(
      comment_params.merge(user: current_user)
    )

    @comment.save!
    render json: @comment, status: :created, location: @article
  rescue StandardError
    render json: { comment: @comment, errors: @comment.errors },
           status: :unprocessable_entity
  end

  def serializer
    CommentSerializer
  end

  private

  def load_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:data).require(:attributes)
          .permit(:content) ||
      ActionController::Parameters.new
  end
end

#location is just the url of the comment from the method show