module ApplicationHelper
  # Returns the full title on a per-page basis.
  # If there is nothing then don't have an extra bar
  def full_title(page_title)
    base_title = "Invictus"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
