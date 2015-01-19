NewsReader.Views.NewSession = Backbone.View.extend({
  tagName: "form",

  template: JST["new_user"],

  render: function (){
    var content = this.template;
    this.$el.html(content);
    return this;
  },

  events: {
    "click .new-user": "signUp"
  },

  signUp: function (event){
    event.preventDefault();
    var formData = this.$el.serializeJSON().user;
    var session = new NewsReader.Models.Session();

    session.save(formData, {
      success: function(response) {
        NewsReader.current_user = new NewsReader.Models.User(
          {id : response.id});
        Backbone.history.navigate("");
        window.location.reload();
      },
      error: function (model, xhr) {
        console.log(xhr);
      }
    });
  }
})
