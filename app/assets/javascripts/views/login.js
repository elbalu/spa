Spa.Views.Login = Backbone.View.extend({
    el: '#loginView',
    template: 'login',
    
    initialize: function () {
        this.collection.on('reset', this.render, this);
    },
    render: function () {
        dust.render('login', {
            users: this.collection
        }, function (err, out) {
            $('#loginView').html(out);
        });
        return this;
    },
    
   
});