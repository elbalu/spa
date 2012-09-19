Spa.Routers.Posts = Backbone.Router.extend({
	 routes: {
    '': 'index',
    'users/show/:id': 'showId',
    'users/:id':'showId'

  },
  
  initialize: function() {
    console.log('post route');

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
  },
  showId: function(id){

   var allUsers=new Spa.Collections.Users();
   var singleUser=new Spa.Models.User({id:id});
   singleUser.collection=allUsers;
   singleUser.fetch({
    success: function() {
      var UsersShow = new Spa.Views.UsersShow({
       model: singleUser 
    });
    $('#users').html(UsersShow.render().el);
    console.log(singleUser); 
    }
   });
   
  }

  
});
