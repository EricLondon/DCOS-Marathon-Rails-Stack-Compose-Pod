class Api::PeopleController < ApplicationController
  def index
    render json: Person.order(id: :asc).limit(10)
  end
end
