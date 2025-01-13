Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? || Rails.env.test?
    provider :github, "Ov23li8ZFg5YjPN8Xozw", "25562e4dda61a61642d0b5a63ce1c46f5f0e1cb9"
  else
    provider :github,
      Rails.application.credentials.github[:client_id],
      Rails.application.credentials.github[:client_secret]
  end
end
