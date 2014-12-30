NewsReader.Views.EntryItem = Backbone.View.extend({
  tagName: "li",

  template: JST["entry_item"],

  render: function (){
    var content = this.template({entry: this.model});
    this.$el.html(content);
    return this;
  }
})
