class Amount < ActiveRecord::Base

  belongs_to :amountable, polymorphic: true

  monetize :value_cents

  validates :name, presence: true
  validates :name, uniqueness: {scope: [:amountable_id, :amountable_type]}

  module Operations

    def +(other_value)
      value + other_value.to_money
    end

    def -(other_value)
      value - other_value.to_money
    end

    def *(multiplier)
      value * multiplier
    end

    def /(divisor)
      value / divisor
    end

    def to_money
      value
    end

  end
  include Operations
end

class NilAmount
  include Amount::Operations
  def value; Money.zero; end
  def amountable; nil; end
end
