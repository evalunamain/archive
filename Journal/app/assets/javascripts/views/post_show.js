JournalApp.Views.PostShow = Backbone.View.extend({
  titleTemplate: JST["show_post_title"],
  bodyTemplate: JST["show_post_body"],

  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "dblclick .title": "editTitle",
    "dblclick .body": "editBody"
  },

  render: function (){
    var title = this.titleTemplate({post: this.model});
    var body = this.bodyTemplate({post: this.model});
    this.$el.html(title).append(body);
    return this;
  },

  editTitle: function() {
    // remove original element
    var content = JST['edit_post_title']({post: this.model});
    this.$el.find(".title").remove();
    this.$el.prepend(content);
    var that = this;
    this.$el.find("input.title").on("blur", function (event){
      var data = $(event.currentTarget).val();
      that.model.save({title: data}, {
        success: function() {
          // that.$el.find("input.title").remove();
          // var title = that.titleTemplate({post: that.model});
          // that.$el.prepend(title);
        }
      });
    })
  },

  editBody: function () {

  }
});
