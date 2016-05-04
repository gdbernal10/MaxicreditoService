# Preview all emails at http://localhost:3000/rails/mailers/scanner_mailer
class ScannerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/scanner_mailer/rates_notification
  def rates_notification
    ScannerMailer.rates_notification
  end

end
