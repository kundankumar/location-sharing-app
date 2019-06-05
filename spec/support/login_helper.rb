def create_current_user_session(user = FactoryGirl.create(:user))
  request.session[:current_user_id] = user.id
end
