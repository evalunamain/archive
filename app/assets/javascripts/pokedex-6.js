Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": "pokemonIndex",
    "pokemon/:id": "pokemonDetail",
    "pokemon/:pokemonId/toys/:toyId" : "toyDetail",
  },

  pokemonDetail: function (id, callback) {
    $("#pokedex .toy-detail").empty();
    var indexCallback = this.pokemonDetail.bind(this, id, callback);

    if (!this._pokemonIndex) {
      this.pokemonIndex(indexCallback);
    } else {
      var pokemon = this._pokemonIndex.collection.get(id);

      var pokeDetail = new Pokedex.Views.PokemonDetail({model: pokemon});
      this._pokemonDetailView = pokeDetail;
      pokeDetail.refreshPokemon(callback);
      $("#pokedex .pokemon-detail").html(pokeDetail.$el);
    }

  },

  pokemonIndex: function (callback) {
    var pokemonIndexView = new Pokedex.Views.PokemonIndex({
      collection: new Pokedex.Collections.Pokemon()
    });


    this._pokemonIndex = pokemonIndexView;
    pokemonIndexView.refreshPokemon(callback);
    $("#pokedex .pokemon-list").html(pokemonIndexView.$el);
    this.pokemonForm();
  },

  toyDetail: function (pokemonId, toyId) {
    var toyDetailCallback = this.toyDetail.bind(this, pokemonId, toyId);

    if (!this._pokemonDetailView){
      this.pokemonDetail(pokemonId, toyDetailCallback);
    } else {
      var toy = this._pokemonDetailView.model.toys().get(toyId);
      var toyDetail = new Pokedex.Views.ToyDetail({model: toy, pokes: this._pokemonIndex.collection});

      $("#pokedex .toy-detail").html(toyDetail.render().$el);
    }

  },

  pokemonForm: function () {
    var pokeForm = new Pokedex.Views.PokemonForm({
      model: new Pokedex.Models.Pokemon,
      collection: this._pokemonIndex.collection});


    $("#pokedex .pokemon-index").prepend(pokeForm.render().$el);
  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
