window.Spa = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  init: function() {
    new Spa.Routers.Posts();
   // new Spa.Routers.Locations();
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Spa.init();
  $('#signIn').click(function(){

  alert("signin");
});
});

