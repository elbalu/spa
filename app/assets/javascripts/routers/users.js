Spa.Routers.Users = Backbone.Router.extend({
	 routes: {
    '/users/show/:id': 'index',
    '/users':'sample'

  },
  
  initialize: function() {
   console.log('user route');
    this.users = new Spa.Collections.Users();
    this.users.fetch();
    console.log('this.users');
    console.log(this.users);
  },
  
  index: function(id) {
  	
  
     var usersView = new Spa.Views.UsersIndex({
      collection: this.users
    });
    $('#users').html(usersView.render().el);
    console.log(usersView.render().el); 
  
  }
});
  
  


    
    