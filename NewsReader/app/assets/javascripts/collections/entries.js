NewsReader.Collections.Entries = Backbone.Collection.extend({
  initialize: function (models, options){
    this.feed = options.feed;
  },

  url: function() {
    return this.feed.url() + '/entries';
  },

  model: NewsReader.Models.Entry,

  comparator: function(entry) {
    return String.fromCharCode.apply(String,
      _.map(entry.get('published_at').split(""), function (c) {
        return 0xffff - c.charCodeAt();
      })
    );
  }
});
