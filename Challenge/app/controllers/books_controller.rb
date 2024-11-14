class BooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    render json: Book.find_all
  end

  def show
    render json: Book.find_by_id(params[:id].to_i)
  rescue => ex
    render json: { error: ex }, status: 404
  end

  def create
    render json: Book.create(
      params
    )
  rescue => ex
    render json: { error: ex }, status: 400
  end

  def destroy
    book = Book.create(params)
    book.destroy!
  end
end
