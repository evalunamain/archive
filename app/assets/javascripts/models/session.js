NewsReader.Models.Session = Backbone.Model.extend({
  urlRoot: "api/session",

  toJSON: function (options){
    return {user: _.clone(this.attributes)};
  }
})
