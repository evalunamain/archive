NewsReader.Routers.NewsRouter = Backbone.Router.extend({

  initialize: function(options){
    this.$rootEl = options.$rootEl;
  },

  routes: {
    "": "feedIndex",
    "feeds/:id": "feedShow",
    "users/new": "newUser",
    "session/new": "newSession"
  },

  feedIndex: function (){
    var feeds = new NewsReader.Views.FeedIndex({collection: NewsReader.feeds});
    this._swapView(feeds);
  },

  feedShow: function (id){
    var feed = NewsReader.feeds.getOrFetch(id);
    var feedView = new NewsReader.Views.FeedShow({model: feed});
    this._swapView(feedView);
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
