import 'package:academicpanel/model/Announcement/announcement_model.dart';
import 'package:academicpanel/model/ClassSchedule/classSchedule_model.dart';
import 'package:academicpanel/model/courseSuperModel/sectionSuper_model.dart';
import 'package:academicpanel/model/user/user_model.dart';
import 'package:academicpanel/network/save_data/firebase/fireBase_DataPath.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CourseController extends GetxController {
  final FirebaseDatapath firebaseDatapath = FirebaseDatapath();
  Future<SectionsuperModel> fetchSectionData({
    required UserModel userModel,

    required bool getClassSchedule,
    required bool getAnnouncement,
  }) async {
    try {
      final department = userModel.department;
      final courses = userModel.current_course ?? {};

      // 1. Loop through courses
      final courseFutures = courses.entries.map((entry) async {
        String courseCode = entry.key;
        String sectionId = entry.value;

        final courseRef = firebaseDatapath.courseData(department, courseCode);

        // Fetch Data
        final results = await Future.wait([
          courseRef.get(),
          courseRef.collection('section').doc(sectionId).get(),
        ]);

        final infoSnapshot = results[0];
        final sectionSnapshot = results[1];

        // Temp variables to hold what we find for THIS specific course
        ClassscheduleModel? foundSchedule;
        List<AnnouncementModel> foundAnnouncements = [];

        if (infoSnapshot.exists && sectionSnapshot.exists) {
          final infoData = infoSnapshot.data() ?? {};
          final secData = sectionSnapshot.data() ?? {};
          final courseName = infoData['name'] ?? courseCode;
          final Code = infoData['code'] ?? courseCode;

          // --- BLOCK 1: SCHEDULE ---
          if (getClassSchedule) {
            // print("i am in the getClassSchedule");
            // Calculate Day Key (e.g., 'mo', 'tu')
            final now = DateTime.now();
            final days = ['mo', 'tu', 'we', 'th', 'fr', 'sa', 'su'];
            // Note: weekday is 1=Mon, 7=Sun. List index is 0-6.
            // Map 1(Mon)->0('mo'), 7(Sun)->6('su')
            String dayKey = days[now.weekday - 1];

            final scheduleMap = secData['schedule'] as Map<String, dynamic>?;

            if (scheduleMap != null && scheduleMap.containsKey(dayKey)) {
              foundSchedule = ClassscheduleModel.fromJoinedData(
                courseInfo: infoData,
                sectionData: secData,
                daySchedule: scheduleMap[dayKey],
                defaultCode: courseCode,
              );
            }
          }

          // --- BLOCK 2: ANNOUNCEMENTS ---
          if (getAnnouncement) {
            final rawList = secData['announcement'] as List<dynamic>?;

            if (rawList != null) {
              foundAnnouncements = rawList.map((item) {
                final map = item as Map<String, dynamic>;
                return AnnouncementModel(
                  message: map['message'] ?? '',
                  // IMPORTANT: Keep as DateTime for sorting! Format in UI instead.
                  date: (map['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
                  name: courseName,
                  code: Code,
                );
              }).toList();
            }
          }
        }

        // Return a mini-model for just this one course
        return SectionsuperModel(
          schedules: foundSchedule != null ? [foundSchedule] : [],
          announcements: foundAnnouncements,
        );
      });

      // 2. Wait for all courses to finish
      final results = await Future.wait(courseFutures);

      // 3. Aggregate (Combine) the results
      List<ClassscheduleModel> allSchedules = [];
      List<AnnouncementModel> allAnnouncements = [];

      for (var result in results) {
        if (result.schedules != null) {
          allSchedules.addAll(
            result.schedules! as Iterable<ClassscheduleModel>,
          );
        }
        if (result.announcements != null) {
          allAnnouncements.addAll(result.announcements!);
        }
      }

      // 4. Sort Announcements (Newest first)
      if (getAnnouncement) {
        allAnnouncements.sort((a, b) => b.date.compareTo(a.date));
      }

      // 6. Return the final Super Model

      return SectionsuperModel(
        schedules: allSchedules,
        announcements: allAnnouncements,
      );
    } catch (e) {
      print("Error fetching data: $e");
      return SectionsuperModel(schedules: [], announcements: []);
    }
  }
}
