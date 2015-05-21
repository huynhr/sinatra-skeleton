# Homepage (Root path)
helpers do
  def current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end  
end

get '/' do
  @movies = Movie.all.reverse
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  email = params[:email]
  password = params[:password]

  user = User.find_by(email: email)
  if user.password == password
    session[:user_id] = user.id
    redirect '/'
  elsif
    redirect '/login'
  else
    redirect '/signup'
  end
end 

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

post '/signup' do 
  email = params[:email]
  password= params[:password]

  user = User.find_by(email: email)
  if user
    redirect '/signup'
  else
    user = User.create(email: email, password: password)
    session[:user_id] = user.id
    redirect '/'
  end
end

get '/profile' do
  erb :profile
end

get '/signup' do
  erb :signup
end

get '/movies/new' do
  erb :new_movie
end

post '/movies/create' do
  title = params[:title]
  genre = params[:genre]
  ratings = params[:ratings]
  director = params[:directed_by]
  img = params[:img]
 movie = current_user.movies.create title: title, genre: genre, ratings: ratings, directed_by: director, img: img
 redirect "/movies/#{movie.id}"
end

get '/movies/:id' do
  @movie = Movie.find(params[:id])
  erb :movie
end

get '/profile/edit' do 
  current_user
  erb :profile_edit
end

post '/profile/edit' do
  email = params[:email]
  password = params[:password]

  current_user.update email: email, password: password
  redirect '/'
end

before do
  redirect '/login' if !current_user && request.path != '/login' && request.path != '/signup'
end
