module WikisHelper
  def user_is_authorised_for_private_wiki?
    current_user && current_user.premium?
  end
end
