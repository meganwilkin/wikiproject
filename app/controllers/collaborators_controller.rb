class CollaboratorsController < ApplicationController
  # list of users with add/remove collaborator sorted on status
  # add collaborator
    # collaborators/create
    # create collaborator with user_id and wiki_id
  # remove collaborator
    # collaborators#delete/destroy
    #  delete collaborator matching userID and wiki_id

  def index
    # @collaborators = Users.all_except.current_user
  end

  def show
    @wiki = Wiki.find(params[:id])
    @collaborators = @wiki.users

    # Need a means of building an exclude list
    exclude_ids = [current_user.id]

    @collaborators.each { |x| exclude_ids.push(x.id) }

    # Should find the correct check here not just know it is role of 1
    admin_users = User.where('role = 1')
    admin_users.each { |x| exclude_ids.push(x.id) }

    @users = User.where('id NOT IN (:ids)', ids: exclude_ids)
  end

  def create
    #logger.debug params.inspect
    #logger.debug params[:wiki_id]
    @wiki = Wiki.find(params[:wiki_id])

    ticked_boxes = params[:collaborator_ids]

    @wiki.users.delete_all
    ticked_boxes.each { |x|
      user = User.find(x)
      @wiki.users << user
    }

    flash[:notice] = "Collaborators updated successfully"
    redirect_to collaborator_path(@wiki)
  end

end
