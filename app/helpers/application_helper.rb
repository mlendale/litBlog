module ApplicationHelper
   def full_title(page_title = '')
    base_title = "litBlog"
    page_title.empty? ? base_title : page_title + " _ " + base_title
  end
end
