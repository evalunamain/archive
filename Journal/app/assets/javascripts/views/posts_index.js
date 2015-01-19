JournalApp.Views.PostsIndex = Backbone.View.extend ({
  tagName: 'ul',

  initialize: function() {
    this.listenTo(this.collection, "sync add change:title remove reset", this.render);
  },

  render: function() {
    this.$el.empty();
    var that = this;
    that.collection.each(function (post) {
      var view = new JournalApp.Views.PostListItem({model: post});
      that.$el.append(view.render().$el);
    });

    return this;
  }
});

// $(function (){
//   var posts = new JournalApp.Collections.Posts;
//   posts.fetch({
//     success: function (){
//       var postsIndex = new JournalApp.Views.PostsIndex({collection: posts});
//       $("body").append(postsIndex.render().$el);
//     }
//   });
// });
