window.Spa = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  init: function() {
    new Spa.Routers.Posts();
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Spa.init();
});

