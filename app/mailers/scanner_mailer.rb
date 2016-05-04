class ScannerMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.scanner_mailer.rates_notification.subject
  #
  def rates_notification(s,products)
    puts('BEGIN rates_notification')
    index = 0
    @user = s.user
    @validProducts = []
    products.each do | p |
      validRate = Finance.filterTerm(p.rates,s.term)
      if !!validRate and  Finance.validateSalary(p,s.salary)
        monthlyPayment = Finance.getMonthlyPayment(s.amount, s.term, validRate)
        totalPayment = Finance.getTotalPayment(monthlyPayment, s.term)
        monthlyRate = Finance.getMonthlyRate(validRate.value)
        totalRatePayment = (totalPayment - s.amount.to_f)
        monthlyPayment = "$" + "%0.2f" % [monthlyPayment]
        totalPayment = "$" + "%0.2f" % [totalPayment]
        monthlyRate_ini = monthlyRate
        monthlyRate = "%0.2f" % [monthlyRate] + "%"
        @validProducts[index] = {code:p.code,monthlyRate_ini:monthlyRate_ini,monthlyRate:monthlyRate,monthlyPayment:monthlyPayment,totalPayment:totalPayment}
        index = @validProducts.length
        if index == 5
          break
        end
      end
    end
    @validProducts = JSON.parse(@validProducts.to_json, object_class: OpenStruct)
    @validProducts = @validProducts.sort_by {|t|t.monthlyRate_ini}
    mail to: s.user.email,from: "scanner.maxicredito@maxicredito.co", subject: "Scanner - Productos Financieros"
    #mail to: "gdbs887@gmail.com",from: "scanner.maxicredito@maxicredito.co", subject: "Scanner - Productos Financieros"
  end
end
