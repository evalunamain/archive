JournalApp.Views.PostListItem = Backbone.View.extend({
  tagName: 'li',
  template: JST["post_list_item"],

  initialize: function () {
  },

  events: {
    "click button": "removePost"
  },

  render: function (){
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  },

  removePost: function (){
    event.preventDefault();

    this.model.destroy({
      success: function(){
      },

      error: function(model, resp){
      }
    })
  }
})
