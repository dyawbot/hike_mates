import 'package:flutter_debouncer/flutter_debouncer.dart';

mixin ThrollService {
  final throll = Throttler();

  void throttleFunction(Function() action) {
    throll.throttle(
        duration: const Duration(milliseconds: 1500), onThrottle: action);
  }
}

mixin DebounceService {
  final debouncer = Debouncer();

  void debounceFunction(Function() action) {
    debouncer.debounce(
        duration: const Duration(milliseconds: 5000), onDebounce: action);
  }
}
