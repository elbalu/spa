Spa.Views.Login = Backbone.View.extend({
    id: 'loginView',
    template: 'login',
    
    initialize: function () {
        console.log('initialized login view');
        this.collection.on('reset', this.render, this);
    },
    events:{
        'click #signIn':'fetchUser'
    },
    fetchUser:function(){
        alert('click');
    },
    render: function () {
        console.log('##' + this.$el);
        dust.render('login', {
            users: this.collection
        }, function (err, out) {
           this.$el.html(out);
        });
        return this;
    },
    
   
});