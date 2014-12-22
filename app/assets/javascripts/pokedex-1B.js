Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var rootView = this;
  var $div = $('<div class="detail">');
  var img = "<img src="+ pokemon.get('image_url') + ">";
  $div.append(img);
  var $details = $("<ul>");
  $details.append("<li>Name: "+ pokemon.get("name")+"</li>");
  $details.append("<li>Attack: "+ pokemon.get("attack")+"</li>");
  $details.append("<li>Defense: "+ pokemon.get("defense")+"</li>");
  $details.append("<li>Poke type: "+ pokemon.get("poke_type")+"</li>");
  $details.append("<li>Moves: "+ pokemon.get("moves")+"</li>");

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
