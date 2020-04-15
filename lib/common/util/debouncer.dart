import 'dart:async';

class Debouncer<T> {
  Duration delay;
  Function(T) callback;
  bool atBegin;

  Debouncer(this.delay, this.callback, [this.atBegin = false]);

  var timeoutId;

  void debounce(T args) {
    void exec() {
      callback(args);
    }

    void clear() {
      timeoutId = null;
    }

    //cancel the previous timer if debounce is still being called before the delay period is over
    if (timeoutId != null) {
      timeoutId.cancel();
    }
    //if atBegin is true, 'exec' has to executed the first time debounce gets called
    if (atBegin && timeoutId == null) {
      exec();
    }
    //schedule a new call after delay time
    timeoutId = Timer(delay, atBegin ? clear : exec);
  }
}
