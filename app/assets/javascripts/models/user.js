NewsReader.Models.User = Backbone.Model.extend({
  urlRoot: "api/users",

  userFeeds: function() {
    if (!this.feeds){
      this.feeds = new NewsReader.Collections.Feeds([],{user: this});
    }

    return this.feeds;
  },

  parse: function(response) {
    var that = this;
    if (response.feeds) {
      that.userFeeds().set(response.feeds, {parse: true});
      delete response.feeds;
    }

    return response;
  },

  toJSON: function (options){
    return {user: _.clone(this.attributes)};
  }
})
