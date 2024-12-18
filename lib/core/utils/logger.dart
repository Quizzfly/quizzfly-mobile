import 'package:flutter/material.dart';

class Logger {
  static LogMode _logMode = LogMode.debug;
  static void init(LogMode mode) {
    Logger._logMode = mode;
  }

  static void log(dynamic data, {StackTrace? stackTrace}) {
    if (_logMode == LogMode.debug) {
      debugPrint(_logMode.toString());
    }
  }
}

enum LogMode { debug, live }
