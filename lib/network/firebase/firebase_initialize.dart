import 'package:academicpanel/firebase_options.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/utility/error_widget/error_snackBar.dart';
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
        errorSnackBar(
          context,
          title: 'Sorry',
          e: e,
          iconName: ImageStyle.error(),
          color1: Colors.red,
          color2: Colors.white,
        );
        return const SizedBox.shrink();
      },
    );

    rethrow;
  }
}
