Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var rootView = this;
  var $div = $('<div class="detail">');
  var img = "<img src="+ pokemon.escape('image_url') + ">";
  $div.append(img);
  var $details = $("<ul>");
  $details.append("<li>Name: "+ pokemon.escape("name")+"</li>");
  $details.append("<li>Attack: "+ pokemon.escape("attack")+"</li>");
  $details.append("<li>Defense: "+ pokemon.escape("defense")+"</li>");
  $details.append("<li>Poke type: "+ pokemon.escape("poke_type")+"</li>");
  $details.append("<li>Moves: "+ pokemon.escape("moves")+"</li>");

  var $toys = $('<ul class="toys">');
  $div.append($details).append($toys);
  pokemon.fetch({
    success: function () {
      pokemon.toys().forEach( function (toy) {
        rootView.addToyToList(toy);
      })
    }
  });

  this.$pokeDetail.append($div);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {

  var id = $(event.target).data("id");
  var pokemon = this.pokes.get(id);
  this.renderPokemonDetail(pokemon);
};
