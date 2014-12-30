NewsReader.Views.FeedShow = Backbone.View.extend({

  tagName: "ul",

  template: JST["feed_show"],

  initialize: function (){
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "click .refresh": "refreshFeed"
  },

  render: function (){

    var content = this.template({feed: this.model});

    var that = this;
    that.$el.html(content);
    this.model.entries().each(function (entry) {
      var entryView = new NewsReader.Views.EntryItem({model: entry});
      that.$el.append(entryView.render().$el);
    })
    return this;
  },

  refreshFeed: function (event){
    event.preventDefault();
    this.model.fetch();
  }

})
