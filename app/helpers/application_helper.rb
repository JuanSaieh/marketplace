module ApplicationHelper
  def thumbnail img
    return img.variant(resize: '270x270!')
  end
end
