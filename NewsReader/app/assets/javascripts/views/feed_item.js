NewsReader.Views.FeedItem = Backbone.View.extend({
  tagName: "li",

  template: JST["feed_list_item"],

  render: function (){
    var content = this.template({feed: this.model});
    this.$el.html(content);
    return this;
  },

  events: {
    "click .delete":"deleteFeed"
  },

  deleteFeed: function (event){
    event.preventDefault();
    this.model.destroy();
    this.remove();
  }
})
