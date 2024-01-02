def compute_rent_days(rent)
  start_date = Date.parse(rent["start_date"])
  end_date =  Date.parse(rent["end_date"])

  return end_date - start_date + 1
end