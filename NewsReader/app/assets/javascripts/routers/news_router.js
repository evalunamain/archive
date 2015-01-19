NewsReader.Routers.NewsRouter = Backbone.Router.extend({

  initialize: function(options){
    this.$rootEl = options.$rootEl;
  },

  routes: {
    "": "feedIndex",
    "feeds/:feed_id": "feedShow",
    "users/new": "newUser",
    "session/new": "newSession"
  },

  feedIndex: function (){
    var that = this;

    if (NewsReader.current_user) {
      NewsReader.current_user.fetch({
        success: function (){
          var feeds = NewsReader.current_user.userFeeds();
          var feedView = new NewsReader.Views.FeedIndex({collection: feeds});
          that._swapView(feedView);
        }
      });
    }
  },


  feedShow: function (feed_id){
    var that = this;
    if (NewsReader.current_user) {
      NewsReader.current_user.fetch({
        success: function (){
          var feed = NewsReader.current_user.userFeeds().getOrFetch(feed_id);
          var feedView = new NewsReader.Views.FeedShow({model: feed});
          that._swapView(feedView);
        }
      });
    }
  },

  newUser: function() {
    var view = new NewsReader.Views.NewUser();
    this._swapView(view);
  },

  newSession: function (){
    var view = new NewsReader.Views.NewSession();
    this._swapView(view);
  },

  _swapView: function(newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$rootEl.html(newView.render().$el);
  }
})
