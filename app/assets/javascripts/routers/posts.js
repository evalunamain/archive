JournalApp.Router = Backbone.Router.extend({
  initialize: function (options){
    this.$rootEl = options.$rootEl;
  },

  routes: {
    // "": "postsIndex",
    "posts/new": "postNew",
    "posts/:id": "postShow"
  },

  // postsIndex: function (){
  //   var postsIndex = new JournalApp.Views.PostsIndex({collection: JournalApp.posts});
  //   this.$rootEl.html(postsIndex.render().$el);
  // },

  postShow: function (id){
    var post = JournalApp.posts.getOrFetch(id);
    var postShow = new JournalApp.Views.PostShow({model: post});
    this.$rootEl.html(postShow.render().$el);
    this.postUpdate(post);
  },

  postUpdate: function(post) {
    var postUpdate = new JournalApp.Views.PostForm({model: post});
    this.$rootEl.append(postUpdate.render().$el);
  },

  postNew: function () {
    var post = new JournalApp.Models.Post;
    var newPost = new JournalApp.Views.PostForm({model: post, collection: JournalApp.posts});
    this.$rootEl.html(newPost.render().$el);
  }
})
