class Post < ActiveRecord::Base

  self.per_page = 10

  def timestamp
    created_at.strftime('%d %B %Y %H:%M:%S')
  end

end

WillPaginate.per_page = 10
