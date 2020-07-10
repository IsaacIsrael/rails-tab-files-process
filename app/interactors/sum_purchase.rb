class SumPurchase
  include Interactor

  def call
    # TODO
    context.sum = context.purchase
                         &.select(&:valid?)
                         &.map { |purchase| purchase.count * purchase.item.price }
                         &.reduce(:+)

   context.sum ||= Money.new(0)
  end
end
