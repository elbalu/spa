Spa.Views.UsersIndex = Backbone.View.extend({
    el: '#user',
    template: 'user',
    
    initialize: function () {
        this.collection.on('reset', this.render, this);
    },
    render: function () {
        
        dust.render('user', {
            users: this.collection
        }, function (err, out) {
            $('#user').html(out);
        });
        return this;
    },
    
   
});