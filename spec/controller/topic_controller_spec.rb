require 'rails_helper'

RSpec.describe TopicsController, type: :controller do

  before(:all) do
    @admin = User.create(email: "hellokitty@gmail.com", password:"password", username: "hellokitty", role: 2)
    @user = User.create(email: "justanormaljoe@gmail.com", password:"password", username: "jojobeans", role: 0)
    @unauthorized_user = User.create(email: "nono@gmail.com", password: "password", username: "failure", role: 0)
    @topic= Topic.create(title: "I am not a whore", description: "But I like to do it do it do it do it", user_id: "1")
  end

  describe "index topic" do
    it "should render index" do
      get :index
      expect(assigns[:topics].count).to eql(1)
      expect(subject).to render_template(:index)
    end
  end

  describe "create topic" do
    it "should deny if not logged in" do

      epicparams = { topic: { title: "Gravity", description: "John Mayer gets all the chicks wet" } }
      post :create, params: epicparams

      expect(flash[:danger]).to eql("You need to login first!")
    end

    it "should create topic if logged in with admin" do

      epicparams = { topic: { title: "Gravity", description: "John Mayer gets all the chicks wet" } }
      post :create, xhr: true, params: epicparams, session: { id: @admin.id }

      topic = Topic.find_by(title: "Gravity")

      expect(Topic.count).to eql(2)
      expect(topic.title).to eql("Gravity")
      expect(topic.description).to eql("John Mayer gets all the chicks wet")
      expect(flash[:success]).to eql("You've created a new topic.")
    end

    it "should create topic if logged in with user" do

      epicparams = { topic: { title: "Gravity2", description: "John Mayer gets all the chicks wet2" } }
      post :create, xhr: true, params: epicparams, session: { id: @user.id }

      topic = Topic.find_by(title: "Gravity2")
      expect(Topic.count).to eql(2)
      expect(topic.title).to eql("Gravity2")
      expect(topic.description).to eql("John Mayer gets all the chicks wet2")
      expect(flash[:success]).to eql("You've created a new topic.")
    end
  end

    describe "edit topic" do
      it "should redirect if not logged in" do

        params = { id: @topic.id }
        get :edit, params: params

        expect(subject).to redirect_to(root_path)
        expect(flash[:danger]).to eql("You need to login first!")
      end

      it "should redirect if user unauthorized" do
        params = { id: @topic.id, topic: { title: "Gravity", description: "John Mayer gets all the chicks wet"} }
        patch :update, params: params, session: { id: @user.id }
        expect(subject).to redirect_to(root_path)
        expect(flash[:danger]).to eql("You're not authorized")
      end

      it "should render edit" do
        params = { id: @admin.id }
        get :edit, params: params, session: { id: @admin.id }

        current_user = subject.send(:current_user)
        expect(subject).to render_template(:edit)
        expect(current_user).to be_present
      end
    end

    describe "update topic" do
      it "should update topic" do

        epicparams = { id: @topic.id, topic: { title: "Gravity3", description: "John Mayer gets all the chicks wet3" } }
        patch :update, params: epicparams, session: { id: @admin.id }

        @topic.reload
        expect(@topic.title).to eql("Gravity3")
        expect(@topic.description).to eql("John Mayer gets all the chicks wet3")
        expect(flash[:success]).to eql("You've successfully edited this topic.")
      end

      it "should redirect if not logged in" do
        params = { id: @topic.id, topic: { title: "Gravity", description: "John Mayer gets all the chicks wet"} }
        patch :update, params: params
        expect(subject).to redirect_to(root_path)
        expect(flash[:danger]).to eql("You need to login first!")
      end

      it "should redirect if user unauthorized" do
        params = { id: @topic.id, topic: { title: "Gravity", description: "John Mayer gets all the chicks wet"} }
        patch :update, params: params, session: { id: @user.id }
        expect(subject).to redirect_to(root_path)
        expect(flash[:danger]).to eql("You're not authorized")
      end
    end


end
