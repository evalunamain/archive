var readline = require('readline')

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame (){
  this.stacks = [[3,2,1],[],[]];
};

HanoiGame.prototype.isWon = function () {
  return ( (this.stacks[1].length === 3) || (this.stacks[2].length === 3));
};

HanoiGame.prototype.isValidMove = function (startIdx, endIdx) {
  var startLength = this.stacks[startIdx].length
  var endLength = this.stacks[endIdx].length
  if (startLength === 0) {
    return false;
  }
  if (endLength === 0) {
    return true;
  }
  return (this.stacks[startIdx][startLength-1] < this.stacks[endIdx][endLength-1]);

};

HanoiGame.prototype.move = function (startIdx, endIdx) {
  if (!this.isValidMove(startIdx, endIdx)) {
    return false;
  }
  else {
    this.stacks[endIdx] = this.stacks[endIdx].concat([this.stacks[startIdx].pop()]);
    return true;
  }
};

HanoiGame.prototype.print = function () {
  var stackString = JSON.stringify(this.stacks);
  console.log(stackString);
};

HanoiGame.prototype.promptMove = function (callback) {
  this.print();

  reader.question("From which stack do you want to take a disc? ", function(stackOne) {
    reader.question("To which stack do you want to move the disc? ", function(stackTwo) {
      var startStack = parseInt(stackOne);
      var endStack = parseInt(stackTwo);
      callback(startStack, endStack);
    });
  });
};

HanoiGame.prototype.run = function (completionCallback) {
  this.promptMove(function(startStack, endStack) {
    if (!this.move(startStack, endStack)) {
      console.log("Wrong move, try again.");
    }

    if (!this.isWon()) {
      this.run(completionCallback);
    } else {
      console.log("You won!");
      completionCallback();
    }
  }.bind(this));
};

var hanoi = new HanoiGame([[3,2,1],[],[]]);

hanoi.run(function(){
  reader.close()}
  );
