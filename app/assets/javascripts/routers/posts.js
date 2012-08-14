Spa.Routers.Posts = Backbone.Router.extend({
	 routes: {
    '': 'index'
  },
  
  initialize: function() {
    this.posts = new Spa.Collections.Posts();
    this.posts.fetch();
  },
  
  index: function() {
  	
    var postsView = new Spa.Views.PostsIndex({
      collection: this.posts
    });
    $('#posts').html(postsView.render().el);
  }
});
