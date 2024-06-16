import 'dart:developer';

import 'package:flutter/foundation.dart';

void printOut(String? msg) async {
  if (msg != null && msg.isNotEmpty && kDebugMode) {
    try {
      log('::: $msg');
    } catch (error) {
      log(msg);
    }
  } else {
    log('S.O.S => printing a null value');
  }
}