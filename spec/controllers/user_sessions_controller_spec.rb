require 'spec_helper'

describe UserSessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it 'renders the new template' do
      get 'new'
      expect(response).to render_template('new')
    end 

  end

  describe "POST 'create'" do
    
    context "with correct credentials" do
    
      let!(:user){User.create(first_name: "User", last_name: "Test", email: "user@user.com", password: "password", password_confirmation: "password")}  

      it 'redirects to the todo list path' do
        post :create, email: 'user@user.com', password: 'password'
        expect(response).to be_redirect
        expect(response).to redirect_to(todo_lists_path)
      end 

      it 'finds the user' do
        expect(User).to receive(:find_by).with({email: "user@user.com"}).and_return(user)
        post :create, email: "user@user.com", password: "password"
      end 

      it 'authenticates the user' do
        User.stub(:find_by).and_return(user)
        expect(user).to receive(:authenticate)
        post :create, email: "user@user.com", password: "password"
      end 

      it 'sets the user_id in the session' do

        post :create, email: "user@user.com", password: "password"
        expect(session[:user_id]).to eq(user.id)


      end 

    end
  end
end
