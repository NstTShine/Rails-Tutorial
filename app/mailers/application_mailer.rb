class ApplicationMailer < ActionMailer::Base
  default from: Settings.mailer.default_email
  layout "mailer"
end
