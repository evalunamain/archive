JournalApp.Views.PostForm = Backbone.View.extend({
  template: JST['post_form'],
  tagName: "form",

  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
    console.log(this.collection);
  },

  events: {
    "submit": "updatePost"
  },

  render: function(model){
    if (!model){
      model = this.model;
    }

    var content = this.template({post: model});

    this.$el.html(content);
    return this;
  },

  updatePost: function(event) {
    event.preventDefault();
    var $form = this.$el;
    var that = this;
    var data = $form.serializeJSON().post;
    this.model.save(data, {
      success: function (){
        that.remove();
        that.collection && that.collection.add(that.model, {merge: true});
        Backbone.history.navigate("", {trigger: true});
      },

      error: function(model, xhr) {
        var newModel = new JournalApp.Models.Post(data);
        newModel.validationError = xhr.responseJSON;
        that.render(newModel);
      }
    });
  }


})
