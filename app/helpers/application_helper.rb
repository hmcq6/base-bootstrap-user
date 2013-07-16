module ApplicationHelper

  def can_post? (user)

    if @cur_user.nil?
      return false
    end

    if @cur_user.try(:admin) || ( @cur_user.try(:guest) == false )
      return true
    else
      return false
    end

  end

end
