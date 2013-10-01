
class UsersController < ApplicationController
  before_filter :cors
  before_filter :important_stuff

  def important_stuff #also, maybe this could be defined in sessions controller
    ## you are logged in
    ## AND the profile you are attempting to view/create/update/edit/whatever is absolutely your profile
  end

  def index
    randomUI = User.all.count
    user = User.find(rand(1..randomUI))
    photo = user.photo
    user_data = { id: user.id, name: user.name, age: user.age, sex: user.sex, sexPreference: user.sex_preference, photo_url: photo.url }
    render :json => user_data.to_json
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    p params
  	user = User.find(params[:id])
    user.update_attributes(longitude: params[:longitude])
    render :json => { :user => @user }

    # user.update_attributes(sex_preference: params[:sex_preference], tagline: params[:tagline], sex: params[:sex])
  end

  def show

    raise ArgumentError, "#show can only return a random user" unless params[:id] == "random"
    offset = rand(User.count)
    user = User.first(:offset => offset)
    user_data = { id: user.id, name: user.name, age: user.age, sex: user.sex, sexPreference: user.sex_preference, photo: user.photo.url }
    render :json => user_data.to_json

  end

  def create
    user = User.new(name: params[:name], age: params[:age], sex: params[:sex], sex_preference: params[:sex_preference], email: params[:email], tagline: params[:tagline], photo: params[:photo])
    user.password = params[:password]
    p "*"*40
    p params



    if user.save
      login(user)
      render :json => user.to_json
    else
      render :json => "false"
    end

  end

  def new
    @user = User.new
  end

end



