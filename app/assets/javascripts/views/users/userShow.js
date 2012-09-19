Spa.Views.UsersShow = Backbone.View.extend({
    el: '#user',
    template: 'userShow',
    
    initialize: function () {
         this.model.on("change", this.render, this);
    },
    render: function () {
        console.log(this);
        dust.render('userShow', {
            user: this.model
        }, function (err, out) {

          console.log('out');
          console.log(out);
            $('#user').html(out);
        });
        return this;
    },
    
   
});