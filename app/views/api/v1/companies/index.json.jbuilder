json.companies do
  json.array! @companies, :id, :company_name, :cnpj, :state_registration, :fantasy_name, :business_phone
end