import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

part 'network_info_impl.dart';

abstract class NetworkInfo {
  /// Get the value if connected to the internet
  Future<bool> get isConnected;

  /// Emits the changes in the internet connection
  Stream<bool> get onChange;
}
