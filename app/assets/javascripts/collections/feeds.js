NewsReader.Collections.Feeds = Backbone.Collection.extend({
  url: "api/feeds",
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
