module Public::CounselingPostsHelper

  def current_status?(status)
    case status
    when params[:status]
      true
    else
      false
    end
  end

end
