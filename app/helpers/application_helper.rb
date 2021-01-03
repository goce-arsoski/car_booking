module ApplicationHelper
  def between?(min, max)
    utc.between?(min, max)
  end
end
