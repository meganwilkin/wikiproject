require 'rails_helper'

RSpec.describe WikisController, type: :controller do

# Before user logged in
  describe "GET #index" do
    it "returns redirection success" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end

# User logging in
#   before do
#           user = User.create!(user: "Wiki User", email: "user@wiki.com", password: "helloworld")
#           create_session(user)
#         end
  let(:my_wiki) { Wiki.create!(title: 'New Wiki Title', body: 'Body of New Wiki Title', private: false, user_id: nil)}
# # once user logged in

#     describe "GET #index" do
#       it "returns http success" do
#         get :index
#         expect(response).to have_http_status(:success)
#       end
#
#       it "assigns [my_wiki] to @wikis" do
#          get :index
#          expect(assigns(:wikis)).to eq([my_wiki])
#        end
#     end
    describe "GET #index" do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in users (:one)
        it "returns http success" do
            get :index
            expect(response).to have_http_status(:success)
          end
    end
  end

  # describe "GET new" do
  #
  #     it "returns http success" do
  #       get :new
  #       expect(response).to have_http_status(:success)
  #     end
  #
  #     it "renders the #new view" do
  #       get :new
  #       expect(response).to render_template :new
  #     end
  #
  #     it "instantiates @pwiki" do
  #       get :new
  #       expect(assigns(:wiki)).not_to be_nil
  #     end
  #   end
  #
  #   describe "WIKI create" do
  #     it "increases the number of Wiki by 1" do
  #       expect{wiki :create, wiki: {title: "My exciting Wiki", body: "The body of my exciting wiki", private: false, user_id: nil}}.to change(Wiki,:count).by(1)
  #     end
  #
  #     it "assigns the new wilw to @wiki" do
  #       wiki :create, wiki: {title: "My exciting Wiki", body: "The body of my exciting wiki", private: false, user_id: nil}
  #       expect(assigns(:wiki)).to eq Wiki.last
  #     end
  #
  #     it "redirects to the new wiki" do
  #       wiki :create, wiki: {title: "My exciting Wiki", body: "The body of my exciting wiki", private: false, user_id: nil}
  #       expect(response).to redirect_to Wiki.last
  #     end
  #   end

  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end
