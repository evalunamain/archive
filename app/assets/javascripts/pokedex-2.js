Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $li = $("<li class='toy' data-toy-id=" + toy.id + " data-pokemon-id=" + toy.get('pokemon_id') + ">");
  $li.append("<h4>Name: " + toy.get("name")+"</h4>");
  $li.append("<li>Happiness: " + toy.get("happiness")+"</li>");
  $li.append("<li>Price: " + toy.get("price")+"</li>");

  $("ul.toys").append($li);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  var $div = $("<div class=detail>");
  var img = "<img src="+ toy.get('image_url') + ">";
  var $select = $("<select data-toy-id=" + toy.id + " data-pokemon-id=" + toy.get('pokemon_id') + ">");
  this.pokes.forEach(function (pokemon) {
    if (pokemon.id === toy.get("pokemon_id")) {
      var $option = $("<option value="+ pokemon.id + " selected>"+pokemon.get("name")+"</option>");
    } else {
      var $option = $("<option value="+ pokemon.id +">"+pokemon.get("name")+"</option>");
    }
    $select.append($option);
  })
  $div.append(img);
  this.$toyDetail.append($div).append($select);

};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var toyId = $(event.currentTarget).data("toy-id");
  var pokemonId = $(event.currentTarget).data("pokemon-id");
  var pokemon = this.pokes.get(pokemonId);
  var toy = pokemon.toys().get(toyId);
  this.renderToyDetail(toy);
};
