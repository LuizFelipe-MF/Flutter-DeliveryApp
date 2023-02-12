import 'package:app/app.dart';
import 'package:app/app/core/config/env/env.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await Env.i.load();

  runApp(const App());
}
