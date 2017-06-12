module WikisHelper
  def user_is_authorised_for_private_wiki?
    current_user.premium?
  end

  def user_only_authorised_for_public_wiki?
    current_user.standard? || current_user.admin?
  end

  def wiki_public?
    @wiki.private == false
  end
end
