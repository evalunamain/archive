Array.prototype.transpose = function () {
  var columns = [];
  for (var i = 0; i < this[0].length; i++) {
    columns.push([]);
  }

  for (var i = 0; i < this.length; i++) {
    for (var j = 0; j < this[i].length; j++) {
      columns[j].push(this[i][j]);
    }
  }

  return columns;
};

function Board () {
  this.rows = [[null,null,null],[null,null,null],[null,null,null]];
};

Board.prototype.won = function () {
  var won = false;


  this.rows.forEach( function(row){
    if (row.every( function(el) {
      return ((el === 'X') || (el === 'O'));
    })) {
      won = true;
      return;
    }
  });

  if (won) {
    return won;
  }

  var cols = this.rows.transpose();
  cols.forEach( function(col){
    if (col.every( function(el) {
      return ((el === 'X') || (el === 'O'));
    })) {
      won = true;
      return;
    }
  });

  if (won) {
    return won;
  }

  var diagonals = [[this.rows[0][0], this.rows[1,1], this.rows[2,2]],
                  [this.rows[0][2], this.rows[1,1], this.rows[2][0]]];

  diagonals.forEach( function(diag){
    if (diag.every( function(el) {
      return ((el === 'X') || (el === 'O'));
    })) {
      won = true;
      return;
    }
  });

  return won;
};

Board.prototype.winner = function () {


};

Board.prototype.print = function() {
  var boardString = JSON.stringify(this.rows);
  console.log(boardString);
}

Board.prototype.empty = function (pos) {
  var spot = this.rows[pos[0]][pos[1]];
  return (spot === null);
};

Board.prototype.placeMark = function (pos, mark) {
  this.rows[pos[0]][pos[1]] = mark;
};

module.exports = Board;
