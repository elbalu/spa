Spa.Routers.Posts = Backbone.Router.extend({
	 routes: {
    '': 'index'

  },
  
  initialize: function() {
    this.posts = new Spa.Collections.Posts();
    this.posts.fetch();
     console.log('this.posts');
    console.log(this.posts);
   /* this.locations = new Spa.Collections.Locations();
    this.locations.fetch();
    console.log('this.locations');
    console.log(this.locations);*/
    this.users = new Spa.Collections.Users();
    this.users.fetch();
    console.log('this.users');
    console.log(this.users);
  },
  
  index: function() {
  	
    var postsView = new Spa.Views.PostsIndex({
      collection: this.posts
    });
    $('#posts').html(postsView.render().el);
    console.log(postsView.render().el); 
     var usersView = new Spa.Views.UsersIndex({
      collection: this.users
    });
    $('#users').html(usersView.render().el);
    console.log(usersView.render().el); 
   /* var locationsView = new Spa.Views.LocationsIndex({
      collection: this.locations
    });
    $('#mapCanvas').html(locationsView.render().el);
    console.log(locationsView.render().el);*/
  }
});
