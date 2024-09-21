module ApplicationHelper
  def flash_class_for(key)
    case key
    when 'notice', 'success'
      'success'
    when 'alert', 'error'
      'error'
    else
      'error'
    end
  end
end
