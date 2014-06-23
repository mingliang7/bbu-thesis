class PaymentNotification < ActiveRecord::Base
  belongs_to :cart
  belongs_to :user
  serialize :params
  after_create :mark_cart_as_purchased
  
private
  def mark_cart_as_purchased
    if status == "Completed"
      cart.update_attributes(:purchased_at => Time.now)
      cart.update_attributes(:user_id => current_user.id)
    end
  end
end
