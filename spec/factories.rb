#by using the symbol ':user', we get Factory Girl to simulate the User model
Factory.define :user do |user|
  user.name                   "Michael Jackson"
  user.email                  "mj@sonymusic.com"
  user.password               "moonwalk"
  user.password_confirmation  "moonwalk"
end
