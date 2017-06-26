module WikisHelper
  def user_is_authorised_for_private_wiki?
    current_user.premium? || current_user.admin?
  end

  def user_only_authorised_for_public_wiki?
    current_user.standard?
  end

  def wiki_public?
    @wiki.private? == false || nil
  end

  def wiki_private?
    @wiki.private? == true
  end

  def collaborator_for_private_wiki?
    @wiki.collaborator.user_id?
  end

end
