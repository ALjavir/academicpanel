import 'package:academicpanel/controller/home/home_controller.dart';
import 'package:academicpanel/controller/user/user_controller.dart';
import 'package:academicpanel/features/home/widget/home_top_header.dart';
import 'package:academicpanel/model/home/home_model.dart';
import 'package:academicpanel/theme/animation/animation_theme.dart';
import 'package:academicpanel/theme/shadow_container/shadow_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class HomePageMain extends StatefulWidget {
  const HomePageMain({super.key});

  @override
  State<HomePageMain> createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain> {
  final homeController = Get.put(HomeController());
  final storage = const FlutterSecureStorage();

  // 1. Change this: Store the FUTURE, not the model itself
  // Replace 'dynamic' with your actual model class name (e.g., HeaderModel)
  late Future<dynamic> _headerFuture;

  @override
  void initState() {
    super.initState();
    // 2. Start the fetch immediately, but DO NOT await it here.
    // We just store the "promise" that data is coming.
    _headerFuture = homeController.fetchHomePageHeader();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Keep your animation wrapper
      body: AnimationTheme(
        // 3. Use FutureBuilder to handle the async data
        child: FutureBuilder(
          future: _headerFuture,
          builder: (context, snapshot) {
            // CASE A: Still Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            // CASE B: Error occurred
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            // CASE C: Data Ready!
            // snapshot.data contains your model now
            final headerData = snapshot.data;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  // Pass the fetched data to your widget
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: HomeTopHeader(homeTopHeaderModel: headerData),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
