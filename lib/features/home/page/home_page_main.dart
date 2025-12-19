import 'package:academicpanel/controller/home/home_controller.dart';
import 'package:academicpanel/features/home/widget/home_top_header2.dart';
import 'package:academicpanel/features/home/widget/today_classSchedule.dart';
import 'package:academicpanel/model/home/home_model.dart';
import 'package:academicpanel/theme/animation/diagonal_reveal.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/utility/loading/loading.dart';
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
  late Future<HomeModel> homeFuture;

  @override
  void initState() {
    super.initState();
    // 2. Start the fetch immediately, but DO NOT await it here.
    // We just store the "promise" that data is coming.
    homeFuture = homeController.mainHomeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        leading: SizedBox.shrink(),
        backgroundColor: ColorStyle.light,
      ),
      backgroundColor: ColorStyle.light,
      // Keep your animation wrapper
      body: DiagonalReveal(
        // 3. Use FutureBuilder to handle the async data
        child: FutureBuilder(
          future: homeFuture,
          builder: (context, snapshot) {
            // CASE A: Still Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Loading(hight: 100));
            }

            // CASE B: Error occurred
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            // CASE C: Data Ready!
            // snapshot.data contains your model now
            final data = snapshot.data;
            // final classTime = snapshot.data;

            return SingleChildScrollView(
              // padding: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  spacing: 20,
                  children: [
                    // Pass the fetched data to your widget
                    HomeTopHeader2(
                      homeTopHeaderModel: data!.homeTopHeaderModel,
                    ),
                    TodayClassschedule(todayClass: data.todayClassSchedule),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
