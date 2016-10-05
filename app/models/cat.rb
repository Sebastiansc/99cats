class Cat < ActiveRecord::Base
  COLORS = ['black', 'brown', 'white']
  validates :birth_date, :name, presence: true
  validates :color, inclusion: { in: COLORS }

  has_many :cat_rentals, dependent: :destroy

  def age
    Date.today.year - self.birth_date.year
  end


end
