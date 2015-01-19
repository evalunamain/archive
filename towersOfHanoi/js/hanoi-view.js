(function(){
  if (typeof Hanoi === "undefined") {
    window.Hanoi = {};
  }

  var View = Hanoi.View = function(game, $el) {
    this.game = game;
    this.board = $el;
    this.pile = null;
    this.render();
  };

  View.prototype.renderDiscs = function(){
    var $lis = $("li");

    $.each($lis, function (i, li) {
      var li = $(li)
      var pos = li.data("id");
      var value = this.game.towers[pos[0]][pos[1]]
      if (value === 3) {
        li.toggleClass("three");
      } else if (value === 2) {
        li.toggleClass("two");
      } else if (value === 1) {
        li.toggleClass("one");
      }
    }.bind(this));
  };

  View.prototype.render = function(){
    this.board.empty();

    for (var i = 0; i < 3; i++){
      var $ul = $("<ul></ul>");

      for (var j = 2; j >= 0; j--) {
        var $li = $("<li></li>");
         $li.data("id", [i, j]);
         $ul.append($li);
      }

      this.board.append($ul);
    }

    this.renderDiscs();
    this.clickTower();
  };

  View.prototype.clickTower = function () {
    var piles = [];


    $("ul").on("click", "li", function(event) {
      console.log(this.pile);
      var $li = $(event.target);
      var pos = $li.data("id");
      var $ul = $(event.delegateTarget);
      console.log($ul);

      if (this.pile === null) {
        this.pile = pos[0];
        piles.push(pos[0]);
        $ul.children().toggleClass("highlight");
      } else {
        piles.push(pos[0]);
        this.pile = null;
        this.makeMove(piles, $ul);
      }
    }.bind(this));

  };

  View.prototype.makeMove = function(piles, $ul) {
    if (this.game.move(piles[0], piles[1])) {
        this.render();
      if (this.game.isWon()) {
        var ul = $("ul")[piles[1]];
        console.log(ul);
        $(ul).children().toggleClass("highlight");
        alert("You won!");
      }
    } else {
      console.log("invalid move");
      this.render();
    }

  };

})();
