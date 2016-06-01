params = { :users => [

  {:email => 'mark@ski-lines.com',
  :password => 'password',
  :password_confirmation => 'password',
  :admin => true,
  :merchant => true,
  :article_publisher => true,
  

  }
]

}

User.create!(params[:users])
