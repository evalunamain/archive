NewsReader.Views.FeedIndex = Backbone.View.extend({

  tagName: "ul",
  template: JST["index"],

  initialize: function() {
    this.listenTo(this.collection, "sync", this.render)
  },

  render: function (){
    this.$el.html(this.template());

    var that = this;

    this.collection.each(function (feed) {
      var view = new NewsReader.Views.FeedItem({model: feed});
      that.$el.append(view.render().$el);
    });
    return this;
  },

  events: {
    "click .new-feed":"createFeed"
  },

  createFeed: function(event) {
    var view = new NewsReader.Views.FeedForm();
    this.$el.prepend(view.render().$el);
  }
})
