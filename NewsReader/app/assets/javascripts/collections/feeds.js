NewsReader.Collections.Feeds = Backbone.Collection.extend({

  initialize: function (models, options){
    this.user = options.user;
  },

  url: function() {
    return this.user.url() + '/feeds';
  },

  model: NewsReader.Models.Feed,

  getOrFetch: function(id) {
    var feed = this.get(id);
    var that = this;

    if (feed) {
      feed.fetch()
    } else {
      feed = new NewsReader.Models.Feed({ id: id });
      feed.fetch({success: function() {
        that.add(feed);
      },
      });
    }
    return feed;
  },
});
