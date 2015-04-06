class CustomFailure < Devise::FailureApp
  def redirect_url
    root_path(message: "login_failure")
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end