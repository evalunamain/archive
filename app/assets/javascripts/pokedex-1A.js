Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $li = $('<li class="poke-list-item" data-id="'+pokemon.id+'">');
  var name = pokemon.get('name');
  var pokeType = pokemon.get('poke_type');
  $li.html(name + ", " + pokeType);
  this.$pokeList.prepend($li);
};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {
  var rootView = this;

  this.pokes.fetch({
      success: function () {
        rootView.pokes.forEach(function (pokemon) {
          rootView.addPokemonToList(pokemon)
        })
      }
  });
};
