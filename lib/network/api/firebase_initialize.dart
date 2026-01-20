import 'package:academicpanel/firebase_options.dart';
import 'package:academicpanel/utility/error_snackbar.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> firebaseInitialize() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (kDebugMode) {
      debugPrint('✅ Firebase successfully initialized');
    }
  } catch (e) {
    debugPrint('❌ Firebase initialization failed: $e');
    Builder(
      builder: (context) {
        errorSnackbar(title: 'Sorry', e: e);
        return const SizedBox.shrink();
      },
    );

    rethrow;
  }
}
