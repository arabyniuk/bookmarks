class MainController < ApplicationController
  def index
    @lists = List.all
    @links = Link.all
  end
end
