class ApplicationMailer < ActionMailer::Base
  default from: 'Seenit <no-reply@seenit-app.herokuapp.com>'
  layout 'mailer'
end
