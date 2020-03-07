import 'dart:async';
import 'package:flutter/services.dart';

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/data.json');
}
