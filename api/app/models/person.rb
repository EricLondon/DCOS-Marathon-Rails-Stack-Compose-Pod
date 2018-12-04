class Person < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  class << self
    def generate_some(how_many = 100)
      generate() while(Person.count < how_many)
    end

    def generate()
      Person.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
      )
    end
  end
end
