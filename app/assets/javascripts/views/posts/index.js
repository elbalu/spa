Spa.Views.PostsIndex = Backbone.View.extend({
	el:'#dust',
	template:'demo',
	events: {
    'submit form': 'createPost',
    'click .remove-post': 'removePost'
  },
initialize:function(){
	 this.collection.on('reset', this.render, this);
	
},
render:function(){
	dust.render('demo', {posts: this.collection}, function(err, out) {
     $('#dust').html(out);
    });
    return this;
},
createPost:function(e){
	var target = $(e.target);
				
	e.preventDefault();
	

    
    var attributes = {
      name: $('#new-post-name').val(),
      type: $('#new-post-type').val(),
      uid: $('#new-post-uid').val(),

    }
    console.log("attributes.name");
    console.log(attributes.name);
    this.collection.create(attributes, {
      wait: false,
      success: function() {
        $('#new-post')[0].reset();
       
      },
      error: this.handleError
    });
     this.collection.trigger('reset');
	//alert("created");
},
removePost:function(){
	 event.preventDefault();
    this.collection.get(this.collection.models[0].cid).destroy();
    this.collection.trigger('reset');
},
 handleError: function(post, response) {
    if (response.status == 422) {
      var errors = $.parseJSON(response.responseText).errors;  
      for (attribute in errors) {
        var messages = errors[attribute];
        for (var i = 0, len = messages.length; i < len; i++) {
          message = messages[i];
          alert("" + attribute + " " + message);
        }
      }
    }
  }

});
