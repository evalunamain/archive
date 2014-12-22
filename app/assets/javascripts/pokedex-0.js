window.Pokedex = (window.Pokedex || {});
window.Pokedex.Models = {};
window.Pokedex.Collections = {};

Pokedex.Models.Pokemon = Backbone.Model.extend({
  urlRoot: '/pokemon/',
  toys: function () {
    if (typeof this._toys === "undefined") {
      this._toys = new Pokedex.Collections.PokemonToys;
    }
    return this._toys;
  }
});

Pokedex.Models.Pokemon.prototype.parse = function (payload) {
  if (payload.toys) {
    this.toys().set(payload.toys);
    delete payload.toys;
  }
  return payload;
}

Pokedex.Models.Toy = Backbone.Model.extend({

});

Pokedex.Collections.Pokemon = Backbone.Collection.extend({
  url: '/pokemon/',
  model: Pokedex.Models.Pokemon
});

Pokedex.Collections.PokemonToys = Backbone.Collection.extend({
  model: Pokedex.Models.Toy
});

window.Pokedex.Test = {
  testShow: function (id) {
    var pokemon = new Pokedex.Models.Pokemon({ id: id });
    pokemon.fetch({
      success: function () {
        console.log(pokemon.toJSON());
      }
    });
  },

  testIndex: function () {
    var pokemon = new Pokedex.Collections.Pokemon();
    pokemon.fetch({
      success: function () {
        console.log(pokemon.toJSON());
      }
    });
  }
};

window.Pokedex.RootView = function ($el) {
  this.$el = $el;
  this.pokes = new Pokedex.Collections.Pokemon();
  this.$pokeList = this.$el.find('.pokemon-list');
  this.$pokeDetail = this.$el.find('.pokemon-detail');
  this.$newPoke = this.$el.find('.new-pokemon');
  this.$toyDetail = this.$el.find('.toy-detail');

  this.$pokeList.on("click", "li", function(event) {
    this.selectPokemonFromList(event);
  }.bind(this));

  this.$newPoke.on("submit", function(event) {
    event.preventDefault();
    this.submitPokemonForm(event);
  }.bind(this));

  this.$pokeDetail.on("click", "li.toy", function(event) {
    this.selectToyFromList(event);
  }.bind(this));

  // Click handlers go here.
};

$(function() {
  var $rootEl = $('#pokedex');
	window.Pokedex.rootView = new Pokedex.RootView($rootEl);
  window.Pokedex.rootView.refreshPokemon();
});
