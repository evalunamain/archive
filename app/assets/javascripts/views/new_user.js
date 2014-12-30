NewsReader.Views.NewUser = Backbone.View.extend({
  tagName: "form",
  template: JST["new_user"],

  render: function() {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  events: {
    "click .new-user":"addUser"
  },

  addUser: function(){
    event.preventDefault();
    var formData = this.$el.serializeJSON().user;
    var user = new NewsReader.Models.User();

    user.save(formData, {
      success: function() {
        Backbone.history.navigate("",{trigger: true});
      },
      error: function (model, xhr) {
        console.log(xhr);
      }
    });
  }
})
