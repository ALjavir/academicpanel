import 'package:academicpanel/model/Announcement/announcement_model.dart';
import 'package:academicpanel/model/classSchedule/classSchedule_model.dart';
import 'package:academicpanel/model/superModel/scheduleANDannouncement_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ScheduleandannouncementController extends GetxController {
  Future<ScheduleandannouncementModel> fetchDashboardData({
    required UserModel userModel,
    required FirebaseDatapath firebaseDatapath,
    bool getBoth = false,
    bool getClassSchedule = false,
    bool getAnnouncement = false,
  }) async {
    // Logic: If 'getBoth' is true, force both to true.
    final bool fetchSchedule = getBoth || getClassSchedule;
    final bool fetchAnnounce = getBoth || getAnnouncement;

    // Optimization: If nothing is requested, return empty immediately.
    if (!fetchSchedule && !fetchAnnounce) {
      return ScheduleandannouncementModel(schedules: [], announcements: []);
    }

    List<ClassscheduleModel> allSchedules = [];
    List<AnnouncementModel> allAnnouncements = [];

    try {
      final department = userModel.department;
      final courses = userModel.current_course ?? {};

      // Prepare tasks for parallel execution
      final courseFutures = courses.entries.map((entry) async {
        String courseCode = entry.key;
        String sectionId = entry.value;

        final courseRef = firebaseDatapath.courseData(department, courseCode);

        // Fetch both docs in parallel
        final results = await Future.wait([
          courseRef.get(), // Info Doc (0)
          courseRef
              .collection('section')
              .doc(sectionId)
              .get(), // Section Doc (1)
        ]);

        final infoSnapshot = results[0];
        final sectionSnapshot = results[1];

        if (infoSnapshot.exists && sectionSnapshot.exists) {
          final infoData = infoSnapshot.data() as Map<String, dynamic>? ?? {};
          final secData = sectionSnapshot.data() as Map<String, dynamic>? ?? {};
          final courseName = infoData['name'] ?? courseCode;

          // --- CONDITIONAL BLOCK 1: SCHEDULE ---
          if (fetchSchedule) {
            // Insert your specific schedule logic here (e.g., filtering for "Today")
            // Example:
            /* final todayKey = DateFormat('E').format(DateTime.now()); // "Mon"
             final scheduleMap = secData['schedule'] as Map<String, dynamic>?;
             
             if (scheduleMap != null && scheduleMap.containsKey(todayKey)) {
                allSchedules.add(ClassScheduleModel.fromMap(
                  scheduleMap[todayKey], 
                  courseName, 
                  courseCode
                ));
             }
             */
          }

          // --- CONDITIONAL BLOCK 2: ANNOUNCEMENTS ---
          if (fetchAnnounce) {
            final rawList =
                secData['announcements'] as List<dynamic>?; // Check key!
            if (rawList != null) {
              final courseAnns = rawList.map((item) {
                return AnnouncementModel(
                  message: item['message'] ?? '',
                  date:
                      (item['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
                  name: courseName,
                  code: courseCode,
                );
              }).toList();
              allAnnouncements.addAll(courseAnns);
            }
          }
        }
      });

      // Execute all
      await Future.wait(courseFutures);

      // Sort results if needed

      // if (fetchSchedule) { ... sort schedules by time ... }

      return ScheduleandannouncementModel(
        schedules: allSchedules,
        announcements: allAnnouncements,
      );
    } catch (e) {
      print("Error fetching dashboard data: $e");
      return ScheduleandannouncementModel(schedules: [], announcements: []);
    }
  }
}
