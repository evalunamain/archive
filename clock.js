function Clock(){
  this.currentTime = null;
};

Clock.TICK = 5000;

Clock.prototype.printTime = function (time) {
  // Format the time in HH:MM:SS
  var hours = time.getHours();
  var minutes = time.getMinutes();
  var seconds = time.getSeconds();
  return hours + ':' + minutes + ':' + seconds;
};

Clock.prototype.run = function () {
  this.currentTime = new Date();
  var that = this;

  console.log(this.printTime(this.currentTime));
  window.setInterval(function () {
    that._tick();
  }, Clock.TICK);


  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
};

Clock.prototype._tick = function () {
  this.currentTime.setSeconds(this.currentTime.getSeconds() + 5);
  console.log(this.printTime(this.currentTime));

  // 1. Increment the currentTime.
  // 2. Call printTime.
};

var clock = new Clock();
clock.run();
