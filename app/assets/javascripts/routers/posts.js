Spa.Routers.Posts = Backbone.Router.extend({
	 routes: {
    '': 'index'
  },
  
  initialize: function() {
    this.posts = new Spa.Collections.Posts();
    this.posts.fetch();
    this.locations = new Spa.Collections.Locations();
    this.locations.fetch();
  },
  
  index: function() {
  	
  /*  var postsView = new Spa.Views.PostsIndex({
      collection: this.posts
    });
    $('#posts').html(postsView.render().el);
    console.log(postsView.render().el);*/
    var locationsView = new Spa.Views.LocationsIndex({
      collection: this.locations
    });
    $('#mapCanvas').html(locationsView.render().el);
    console.log(locationsView.render().el);
  }
});
