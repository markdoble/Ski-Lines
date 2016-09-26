module Admin::StripeAccountsHelper
  def fields_needed_translate(field, country)
    case field
    when "external_account"
      "Connect a bank account."
    when "legal_entity.address.city"
      "We need to confirm the city in which your business is located."
    when "legal_entity.address.line1"
      "We need to confirm the address of your business."
    when "legal_entity.address.postal_code"
      "We need to confirm your postal code of your business."
    when "legal_entity.address.state"
      "We need to confirm the state/province in which your business is located."
    when "legal_entity.business_name"
      "We need to confirm the legal name of your business."
    when "legal_entity.dob.day"
      "We need to confirm the day of birth of your company representative."
    when "legal_entity.dob.month"
      "We need to confirm the month of birth of your company representative."
    when "legal_entity.dob.year"
      "We need to confirm the year of birth of your company representative."
    when "legal_entity.first_name"
      "We need to confirm the first name of your company representative."
    when "legal_entity.last_name"
      "We need to confirm the last name of your company representative."
    when "legal_entity.type"
      "We need to confirm the legal entity type of your business (individual of company)."
    when "tos_acceptance.date"
      "You must accept the terms and conditions below."
    when "tos_acceptance.ip"
      "You must accept the terms and conditions below."
    when "legal_entity.verification.document"
      "We have been unable to successfully identify your business with the information you have provided. For security reasons, please upload a photocopy of a government issued ID for your Account Representative."
    when "legal_entity.business_tax_id"
      "Provide your business tax identification number."
    when "legal_entity.personal_id_number"
      "Please have your company representative confirm their social security/insurance number."
    when "legal_entity.ssn_last_4"
      "Please have your company representative confirm the last four digits of their social security number."
    else
      field
    end
  end

  def should_the_form_field_render(fields_needed)
    possible_fields_array = ["external_account",
                            "legal_entity.address.city",
                            "legal_entity.address.line1",
                            "legal_entity.address.postal_code",
                            "legal_entity.address.state",
                            "legal_entity.business_name",
                            "legal_entity.dob.day",
                            "legal_entity.dob.month",
                            "legal_entity.dob.year",
                            "legal_entity.first_name",
                            "legal_entity.last_name",
                            "legal_entity.type",
                            "tos_acceptance.date",
                            "tos_acceptance.ip",
                            "legal_entity.verification.document",
                            "legal_entity.business_tax_id",
                            "legal_entity.personal_id_number",
                            "legal_entity.personal_id_number",
                            "legal_entity.ssn_last_4"]
  end

  def make_country_readable(country_code)
    case country_code
    when "CA"
      "Canada"
    when "US"
      "United States of America"
    else
      country_code
    end
  end

  def make_currency_readable(currency_code)
    case currency_code
    when "cad"
      "CAD"
    when "usd"
      "USD"
    else
      currency_code
    end
  end

  def flag_selector_based_on_currency(country)
    country.downcase
  end

end
