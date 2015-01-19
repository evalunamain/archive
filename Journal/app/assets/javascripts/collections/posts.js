JournalApp.Collections.Posts = Backbone.Collection.extend({
  url: "posts",
  model: JournalApp.Models.Post,

  getOrFetch: function(id) {
    var post = this.get(id);
    if (typeof post === "undefined"){
      post = new JournalApp.Models.Post({id: id});
      post.fetch();
    };

    return post;
  }
})
