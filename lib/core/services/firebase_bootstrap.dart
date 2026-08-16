import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';

/// Result of [FirebaseBootstrap.initialize].
enum FirebaseBootstrapStatus {
  ready,
  notConfigured,
  failed,
}

class FirebaseBootstrapResult {
  const FirebaseBootstrapResult({
    required this.status,
    this.error,
  });

  final FirebaseBootstrapStatus status;
  final Object? error;

  bool get isReady => status == FirebaseBootstrapStatus.ready;
}

/// Initializes Firebase when real options exist; otherwise skips safely.
abstract final class FirebaseBootstrap {
  static Future<FirebaseBootstrapResult> initialize() async {
    if (!DefaultFirebaseOptions.isConfigured) {
      debugPrint(
        'Firebase options are placeholders. '
        'Run `flutterfire configure` before Auth/Firestore phases.',
      );
      return const FirebaseBootstrapResult(
        status: FirebaseBootstrapStatus.notConfigured,
      );
    }

    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      return const FirebaseBootstrapResult(
        status: FirebaseBootstrapStatus.ready,
      );
    } on Object catch (error, stackTrace) {
      debugPrint('Firebase init failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      return FirebaseBootstrapResult(
        status: FirebaseBootstrapStatus.failed,
        error: error,
      );
    }
  }
}
