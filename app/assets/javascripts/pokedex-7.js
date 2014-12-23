Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
    "submit form": "savePokemon"
  },

  render: function () {
    this.$el.append(JST["pokemonForm"]);
    return this;
  },

  savePokemon: function (event) {
    event.preventDefault();
    var formData = $(event.target).serializeJSON()['pokemon'];
    this.model.set(formData)
    this.model.save({}, {
      success: function(){
        this.collection.add(this.model);
        this.collection.trigger("refresh");
        Backbone.history.navigate("pokemon/" + this.model.id, {trigger: true})
      }.bind(this)
    });

  }
});
