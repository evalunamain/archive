window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new NewsReader.Routers.NewsRouter({
      $rootEl: $("#content")
    });
    if (this.user_id){
      this.current_user = new NewsReader.Models.User({id : this.user_id});
      this.current_user.fetch()
    }
    // this.feeds = new NewsReader.Collections.Feeds;
    // this.feeds.fetch();
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
