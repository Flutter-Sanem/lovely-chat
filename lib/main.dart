import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/services/firebase_bootstrap.dart';
import 'core/services/theme_mode_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final FirebaseBootstrapResult firebase =
      await FirebaseBootstrap.initialize();

  debugPrint('Firebase bootstrap: ${firebase.status.name}');

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const AutumnChatApp(),
    ),
  );
}
