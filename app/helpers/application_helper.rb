module ApplicationHelper
  def thumbnail img
    return img.variant(resize: '300x300!')
  end
  
end
