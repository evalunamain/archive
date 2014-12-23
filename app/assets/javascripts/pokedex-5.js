Pokedex.Views = {

}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li": "selectPokemonFromList"
  },

  // initialize: function () {
  //   this.collection = new Pokedex.Collections.Pokemon();
  // },

  addPokemonToList: function (pokemon) {
    var content = JST['pokemonListItem']({pokemon: pokemon });

    this.$el.append(content);
  },

  refreshPokemon: function (callback, options) {
    var that = this;
    this.collection.fetch( {
      success: function(){
        that.render();
        callback && callback();
      }
    })
  },

  render: function () {
    var that = this;
    this.$el.empty();
    this.collection.each(function (pokemon) {
      that.addPokemonToList(pokemon);
    });
    return this;
  },

  selectPokemonFromList: function (event) {
    var $target = $(event.target);
    var pokeId = $target.data('id');

    Backbone.history.navigate("pokemon/" + pokeId, {trigger: true});
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toy-list-item": "selectToyFromList"
  },


  refreshPokemon: function (callback, options) {
    var that = this;
    this.model.fetch({
      success: function () {
        that.render();
        callback && callback();
      }
    });

  },

  render: function () {
    var that = this;
    var pokeDetail = JST["pokemonDetail"]({pokemon: this.model});
    this.$el.html(pokeDetail);

    this.model.toys().each(function (toy){
      var toyItem = JST["toyListItem"]({toy: toy});
        that.$el.append(toyItem);
    });

    return this;
  },

  selectToyFromList: function (event) {

    var toyId = $(event.currentTarget).data("id");

    var toy = this.model.toys().get(toyId);

    Backbone.history.navigate("pokemon/" + toy.get('pokemon_id') +
        "/toys/" + toyId, {trigger: true});

    // var toyDetail = new Pokedex.Views.ToyDetail({model: toy});
    // $("#pokedex .toy-detail").html(toyDetail.$el);
    // toyDetail.render(this.model.collection);
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function (pokes) {
     var toyDetail = JST["toyDetail"]({toy: this.model, pokes: pokes});
     this.$el.html(toyDetail);
     return this;
  }
});


// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
