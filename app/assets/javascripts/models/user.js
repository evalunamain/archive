NewsReader.Models.User = Backbone.Model.extend({
  urlRoot: "api/users",

  toJSON: function (options){
    return {user: _.clone(this.attributes)};
  }
})
