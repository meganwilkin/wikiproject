class ChargesController < ApplicationController

  def show
    @charge = Stripe::Charge.find(params[:id])
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 15_00,
      description:"Wikipedia Premium Plan - #{current_user.email}",
      currency: 'usd'
    )
    update_user_to_premium
    flash[:notice] = "Thank you for your payment, #{current_user.email}! "
    redirect_to root_path(current_user)

    rescue Stripe::CardError => e
        flash[:alert] = e.message
        redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key:"#{Rails.configuration.stripe[:publishable_key] }",
      description:"Wikipedia Premium Plan - #{current_user.username}",
      amount: 15_00
    }
  end

  def destroy
    downgrade_user_to_standard
    # current_user_downgrade_wikis
    current_user_downgrade_wikis
    redirect_to root_path(current_user)
  end

  # def downgrade
  #   if params[:id].nil? # if there is no user id in params, show current one
  #     @user = current_user
  #   else # if there is the user id in params just use it,
  #    # maybe get 'authorization failed'
  #    @user = User.find params[:id]
  #   end
  # end

  # def destroy
  #   if @stripe_btn_data.destroy
  #     downgrade_user_to_standard
  #     current_user_downgrade_wikis
  #     flash[:success] = "Sorry to see you go"
  #     redirect_to root_path(current_user)
  #   else
  #     flash[:error] = "Sorry we can't downgrade you at the moment"
  #     redirect_to root_path(current_user)
  #   end
  # end
end
