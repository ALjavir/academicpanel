import 'package:http/http.dart' as http;
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart'; // Needed for Colors in Get.snackbar
import 'package:get/get.dart';

// bool _mockExternalCheckFailure =
//     false; // Set to true to simulate "connected to Wi-Fi but no data" scenario

Future<bool> _hasInternetAccess() async {
  try {
    final response = await http
        .get(Uri.parse("http://clients3.google.com/generate_204"))
        .timeout(const Duration(seconds: 3));

    return response.statusCode == 204;
  } catch (_) {
    return false;
  }
}

// =======================================================================

class CheckConnection extends GetxService {
  final Connectivity _connectivity = Connectivity();
  RxBool isRotating = false.obs;

  void startRotation() {
    isRotating.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isRotating.value = false;
    });
  }

  /// Performs a robust check for both local network access and external internet access.
  /// If disconnected, shows an error notification via a persistent dialog
  /// that blocks execution until a connection is restored.
  /// Returns true if connected (both local and external), false otherwise.
  Future<bool> checkConnection() async {
    // print("This is inside connectivity_plus - Running robust check.");

    // Step 1: Check local network interface. Now receives a List<ConnectivityResult>.
    final List<ConnectivityResult> localResults = await _connectivity
        .checkConnectivity();

    // Check if any connection type in the list is NOT 'none'.
    final bool hasLocalConnection = localResults.any(
      (result) => result != ConnectivityResult.none,
    );

    // Step 2: Check external internet access if local connection is available
    bool hasExternalAccess = false;
    if (hasLocalConnection) {
      hasExternalAccess = await _hasInternetAccess();
    }

    final isConnected = hasLocalConnection && hasExternalAccess;

    // If NOT connected and no dialog is currently open, show the dialog
    if (!isConnected && !(Get.isDialogOpen ?? false)) {
      // The thread BLOCKS HERE until Get.back() is explicitly called from inside the dialog.
      await Get.dialog(
        PopScope(
          // Prevent dialog from being dismissed by back button/swipes
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'No internet',
                    style: Fontstyle.defult(
                      22,
                      FontWeight.w500,
                      ColorStyle.red,
                    ),
                  ),
                  Divider(height: 1, color: ColorStyle.Textblue),
                  const SizedBox(height: 10),
                  Text(
                    "You are not connected to the internet!!!",
                    style: Fontstyle.defult(
                      14,
                      FontWeight.w600,
                      ColorStyle.Textblue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Display mock image asset
                  Center(
                    child: Image.asset(ImageStyle.no_internet(), scale: 8),
                  ),
                  const SizedBox(height: 20),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        startRotation();
                        final isConnectedNow = await checkConnection();

                        if (isConnectedNow) {
                          Get.back();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: ColorStyle.red,
                        padding: const EdgeInsets.all(10),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(width: 1, color: Colors.white),
                        ),
                      ),
                      label: Text(
                        "Try again",
                        style: Fontstyle.defult(
                          14,
                          FontWeight.bold,
                          Colors.white,
                        ),
                      ),
                      icon: Obx(
                        () => AnimatedRotation(
                          turns: isRotating.value ? 1 : 0,
                          duration: const Duration(seconds: 1),
                          child: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );
      // This return statement is only reached after the dialog is dismissed (connection successful).
      return false;
    }

    // If connected OR if a dialog is already open (to prevent stacking), return the result.
    return isConnected;
  }
}
