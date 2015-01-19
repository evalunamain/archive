window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    this.posts = new JournalApp.Collections.Posts();
    this.posts.fetch();
    new JournalApp.Router({$rootEl: $("#content")});
    var postsIndex = new JournalApp.Views.PostsIndex({collection: this.posts});
    $("#sidebar").html(postsIndex.render().$el);
    Backbone.history.start();
  }
};

$(document).ready(function(){
  JournalApp.initialize();
});
