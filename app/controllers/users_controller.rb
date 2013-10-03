class UsersController < ApplicationController
  before_filter :cors

  def index
    # randomUI = User.all.count
    # user = User.find(rand(1..randomUI))
    # photo = user.photo
    # user_data = { id: user.id, name: user.name, age: user.age, sex: user.sex, sexPreference: user.sex_preference, photo_url: photo.url }
    # render :json => user_data.to_json
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
      user = User.find(params[:id])
      user.update_attributes(longitude: params[:longitude], latitude: params[:latitude])
      render :json => current_user.to_json

  end

  def show
    p params
    #current user that votes

    user = User.find(params[:id])
    
    # potentials = user.get_potentials_for_user
    # p potentials
    # if potentials.empty?
    #   puts "no potentials"
    #    render :json => "Currently, there are no singles around. Check again soon.".to_json
    # else
      votee = user
      # p votee         

      user_data = { id: votee.id, name: votee.name, age: votee.age, sex: votee.sex, sexPreference: votee.sex_preference, photo: votee.photo.url }
      render :json => user_data.to_json
    # end
  end


  def create
    user = User.new(name: params[:name], age: params[:age], sex: params[:sex], sex_preference: params[:sex_preference], email: params[:email], tagline: params[:tagline], photo: params[:photo])
    user.password = params[:password]

    if user.save
      login(user)
      render :json => current_user.to_json
    else
      render :json => ("false").to_json
    end

  end

  def new
   #should this go to sessions controller instead?
    @user = User.new
  end


   def new_message
    @message = ActsAsMessageable::Message.new
  end

  def create_message
    p "**************************************"
    p params[:content]['0']['value'].chomp

    @from = User.find(params[:user_id])
    @to = User.find(params[:receiver_id])
    @from.send_message(@to, params[:content]['0']['value'])


    render json: @to.received_messages.to_json
  end

end



