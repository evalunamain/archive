NewsReader.Views.FeedForm = Backbone.View.extend({
  tagName:"form",
  template: JST["feed_form"],
  render: function() {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  events: {
    "click .create-feed":"createFeed"
  },

  createFeed: function(event) {
    event.preventDefault();
    var formData = this.$el.serializeJSON().feed;
    var feed = new NewsReader.Models.Feed();
    feed.save(formData, {
      success: function() {
        NewsReader.feeds.add(feed);
        this.remove();
      }.bind(this)
    })
  }
});
