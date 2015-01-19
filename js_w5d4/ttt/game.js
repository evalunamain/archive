var Board = require('./board')


function Game (interface) {
  this.board = new Board();
  this.reader = interface;
  this.currentPlayer = "X"
};

Game.prototype.run = function (completionCallback) {
  if (!this.board.won()) {
    this.board.print();


    console.log("Current player is " + this.currentPlayer + ".")
    this.reader.question("Please choose a position: ", function (answer) {
        var pos = answer.split(',').map( function(el) {
        return parseInt(el);
      });

      if (this.board.empty(pos)) {
        this.board.placeMark(pos, this.currentPlayer);
        this.currentPlayer = (this.currentPlayer === "X" ? "O" : "X");
        this.run(completionCallback);
      } else {
        console.log("Invalid move.");
        this.run(completionCallback);
      }
    }.bind(this));

  }

  if (this.board.won()){
    winner = this.currentPlayer === "X" ? "O" : "X"
    console.log("The winner is " + winner + ".");
    completionCallback();
  }
};

module.exports = Game
