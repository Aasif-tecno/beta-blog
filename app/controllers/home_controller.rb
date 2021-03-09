class HomeController < ApplicationController
  def index
    @blogs = Blog.published.most_recently_published
  end

  def terms
  end

  def privacy
  end
end
