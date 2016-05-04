class Finance

  def self.filterTerm(rates, term)
    validRate = nil
    #intTerm = parseInt(term, 10)
    intTerm = Integer(term)

    rates.each do | r |
      if r.minMonths <= intTerm and r.maxMonths >= intTerm
        validRate = r
      end
    end
    return validRate
  end

  def self.getMonthlyPayment(value, term, rate)
    #xValue = parseFloat(value)
    xValue = value.to_f
    xTerm = Integer(term)
    xRate = rate.value.to_f

    mRate = getMonthlyRate(xRate)
    mRateFactor = mRate / 100
    #payment = xValue * ((Math.pow((1 + mRateFactor), xTerm) * mRateFactor) / (Math.pow(1 + mRateFactor, xTerm) - 1))

    payment = xValue * ((((1 + mRateFactor) ** xTerm) * mRateFactor) / (((1 + mRateFactor) ** xTerm) - 1))

    return payment
  end

  def self.getMonthlyRate(anualRate)
    result = ((((1 + anualRate.to_f / 100) ** (30.to_f/360.to_f)))-1) * 100
    return result
  end

  def self.getTotalPayment(monthlyPayment, term)
    #return parseFloat(monthlyPayment) * parseInt(term);
    return monthlyPayment.to_f * Integer(term);
  end

  def self.validateSalary(product, salary)
    xSalary = Integer(salary);
    #if(xSalary === 0) return true;
    if xSalary === 0
      return true
    end

    minSalary = (product.restrictions[0].minSalary).to_f
    return minSalary <= xSalary;
  end
end