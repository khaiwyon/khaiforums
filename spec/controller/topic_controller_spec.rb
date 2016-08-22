require 'rails_helper'

RSpec.describe TopicsController, type: :controller do

  before(:all) do
    @admin = User.create(email: "hellokitty@gmail.com", password:"password", username: "hellokitty", role: 2)
    @user = User.create(email: "justanormaljoe@gmail.com", password:"password", username: "jojobeans", role: 0)
    @topic= Topic.create(title: "I am not a whore", description: "But I like to do it do it do it do it")
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
      binding.pry
      expect(Topic.count).to eql(2)
      expect(topic.title).to eql("Gravity2")
      expect(topic.description).to eql("John Mayer gets all the chicks wet2")
      expect(flash[:success]).to eql("You've created a new topic.")
    end


end
