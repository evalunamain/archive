window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new NewsReader.Routers.NewsRouter({
      $rootEl: $("#content")
    });
    this.feeds = new NewsReader.Collections.Feeds;
    this.feeds.fetch();
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
