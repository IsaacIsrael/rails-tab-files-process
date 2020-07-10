class CreatePurchase
  include Interactor

  def call
    context.purchase = Purchase.create(context.params)

    if context.purchase.is_a?(Array) &&
       !context.purchase.empty? &&
       context.purchase.all?(&:invalid?)

      fail context.purchase
                  .map { |purchase| "At #{purchase.name} erros: #{purchase.errors.full_messages.to_sentence}" }
                  .join('<br>')
    end

    fail context.purchase.errors.full_messages.to_sentence if context.purchase.is_a?(Purchase) &&
                                                              context.purchase.invalid?
  end

  private

  def fail(message)
    context.error = message
    context.fail!
  end
end
