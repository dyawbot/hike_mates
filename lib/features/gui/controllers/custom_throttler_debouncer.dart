import 'dart:async';

mixin CustomThrottleService {
  Timer? _throttleTimer;

  void throttleFunction(Function() action,
      {Duration duration = const Duration(milliseconds: 1500)}) {
    if (_throttleTimer?.isActive ?? false) return;

    _throttleTimer = Timer(duration, () {
      action();
    });
  }

  void cancelThrottle() {
    _throttleTimer?.cancel();
  }
}

mixin CustomDebounceService {
  Timer? _debounceTimer;

  void debounceFunction(Function() action,
      {Duration duration = const Duration(milliseconds: 5000)}) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(duration, () {
      action();
    });
  }

  void cancelDebounce() {
    _debounceTimer?.cancel();
  }
}
