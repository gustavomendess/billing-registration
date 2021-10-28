class Participant < ApplicationRecord
  validates :name, length: { minimum: 3 }, presence: true
  validates :cpf_cnpj, presence: true
  validates :fantasy_name, presence: true
  validates :person_type, presence: true
  validates :client_type, presence: true

  enum person_type: {legal_person: 1, physical_person: 2, foreign:3}
  enum client_type: {customer: 1, supplier: 2, seller:3, carrier:4}
  has_many :contacts
  has_many :addresses
end
