import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:upload_app/firebase_options.dart';
import 'package:upload_app/myapp.dart';
import 'core/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupDependencies();
  runApp(MyApp());
}
