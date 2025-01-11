class ApplicationMailbox < ActionMailbox::Base
  routing (/[0-9]+-comment@/i) => :comments
  # routing -> (inbound_email) { inbound_email.mail.to.size > 2 } => :multiple_recipients
  # routing CustomAddress.new => :custom
  routing :all => :backstop
end
