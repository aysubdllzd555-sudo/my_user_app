
require 'sinatra'
require 'json'
require_relative 'my_user_model'

set :port, 8080
set :bind, '0.0.0.0'
enable :sessions

def filter_user(user)
  return nil if user.nil?
  {
    id: user.id,
    firstname: user.firstname,
    lastname: user.lastname,
    age: user.age,
    email: user.email
  }
end

get '/users' do
  users = User.all
  users_without_password = users.map { |u| filter_user(u) }
  
  users_without_password.to_json
end

post '/users' do
  new_user = User.create(params)
  
  filter_user(new_user).to_json
end

post '/sign_in' do
  users = User.all
  found_user = nil

  users.each do |u|
    if u.email == params[:email] && u.password == params[:password]
      found_user = u
    end
  end

  if found_user
    session[:user_id] = found_user.id
    filter_user(found_user).to_json
  else
    status 401
    { error: "Email or password is incorrect" }.to_json
  end
end

put '/users' do
  if session[:user_id] == nil
    halt 401, { error: "Evvelce giris edin" }.to_json
  end

  updated_user = User.update(session[:user_id], 'password', params[:password])
  filter_user(updated_user).to_json
end

delete '/sign_out' do
  if session[:user_id] == nil
    halt 401, { error: "Evvelce giris edin" }.to_json
  end

  session[:user_id] = nil
  status 204
end

delete '/users' do
  if session[:user_id] == nil
    halt 401, { error: "Evvelce giris edin" }.to_json
  end

  User.destroy(session[:user_id])
  session[:user_id] = nil
  status 204
end

get '/' do
  users = User.all
  rows = users.map do |u|
    "<tr><td>#{u.firstname}</td><td>#{u.lastname}</td><td>#{u.age}</td><td>#{u.email}</td></tr>"
  end.join("\n")

  file_path = File.join(settings.views, 'index.html')
  if File.exist?(file_path)
    html_content = File.read(file_path)
    if html_content.include?('<tbody>')
      html_content.sub('<tbody>', "<tbody>\n#{rows}")
    else
      html_content.sub('</table>', "#{rows}\n</table>")
    end
  else
    "<table>#{rows}</table>"
  end
end