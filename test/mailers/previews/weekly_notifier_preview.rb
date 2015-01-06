# Preview all emails at http://localhost:3000/rails/mailers/weekly_notifier
class WeeklyNotifierPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/weekly_notifier/received
  def received
    WeeklyNotifier.received
  end

end
