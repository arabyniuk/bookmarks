class WeeklyNotifier < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.weekly_notifier.received.subject
  #
  def received(user)
    @greeting = "Hi"
    @links = user.links.last_week
    mail(to: user.email, subject: "hello world!!")
  end
end
