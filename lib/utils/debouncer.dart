import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  /// A length of time in milliseconds used to delay a function call
  final int milliseconds;

  /// A callback function to execute
  VoidCallback? action;

  /// A count-down timer that can be configured to fire once or repeatedly.
  Timer? _timer;

  /// Creates a Debouncer that executes a function after a certain length of time in milliseconds
  Debouncer({this.milliseconds = 300});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
