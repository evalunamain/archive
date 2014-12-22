Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var pokemon = new Pokedex.Models.Pokemon(attrs);
  var rootView = this;
  pokemon.save( {}, {
    success: function(model, response, option) {
      rootView.pokes.add(model);
      rootView.addPokemonToList(model);
      callback(model);
    },
    error: function() {
      console.log("didn't work");
    }
  });
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  var rV = this;
  var formData = $(event.target).serializeJSON();
  this.createPokemon(formData, function (model) {
    rV.renderPokemonDetail(model);
  });
};
