import 'package:academicpanel/model/Announcement/announcement_model.dart';
import 'package:academicpanel/model/Announcement/row_announcement_model.dart';
import 'package:academicpanel/model/ClassSchedule/classSchedule_model.dart';
import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/model/assessment/row_assessment_model.dart';

import 'package:academicpanel/model/courseSuperModel/row_course_model.dart';
import 'package:academicpanel/model/courseSuperModel/sectionSuper_model.dart';
import 'package:academicpanel/model/user/user_model.dart';
import 'package:academicpanel/network/save_data/firebase/fireBase_DataPath.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CourseController extends GetxController {
  final firebaseDatapath = Get.put(FirebaseDatapath());

  Future<SectionsuperModel> fetchSectionData({
    required UserModel userModel,
    bool getAssessment = false,
    bool getClassSchedule = false,
    bool getAnnouncement = false,
  }) async {
    try {
      final studentId = userModel.id; // Use this for result lookup
      final department = userModel.department;
      final courses = userModel.current_course ?? {};

      // 1. Loop through courses
      final courseFutures = courses.entries.map((entry) async {
        String courseCode = entry.key;
        String sectionId = entry.value;

        final courseRef = firebaseDatapath.courseData(department, courseCode);

        // Fetch Basic Data
        final results = await Future.wait([
          courseRef.get(),
          courseRef.collection('section').doc(sectionId).get(),
        ]);

        final infoSnapshot = results[0];
        final sectionSnapshot = results[1];

        // Temp variables
        // ClassscheduleModel? foundSchedule;
        List<ClassscheduleModel> foundSchedules = [];
        List<AnnouncementModel> foundAnnouncements = [];
        List<AssessmentModel> foundAssessments = []; // <--- Temp List

        if (infoSnapshot.exists && sectionSnapshot.exists) {
          final infoData = infoSnapshot.data() ?? {};
          final secData = sectionSnapshot.data() ?? {};

          final rowCourse = RowCourseModel.fromMap(infoData);

          // --- BLOCK 1: SCHEDULE ---

          if (getClassSchedule) {
            final scheduleMap = secData['schedule'] as Map<String, dynamic>?;

            if (scheduleMap != null) {
              // LOOP through every key (su, mo, tu...) found in the map
              scheduleMap.forEach((key, value) {
                // key = "su", value = {startTime: "14:00", ...}
                final singleSchedule = ClassscheduleModel.fromJoinedData(
                  dayKey: key, // Pass the specific day (su, tu)
                  courseInfo: infoData,
                  sectionData: secData,

                  // Pass ONLY the data for this specific day
                  daySchedule: value as Map<String, dynamic>,
                  defaultCode: courseCode,
                );

                // Add to our list
                foundSchedules.add(singleSchedule);
              });
            }
          }

          // --- BLOCK 2: ANNOUNCEMENTS ---
          if (getAnnouncement) {
            final rawList = secData['announcement'] as List<dynamic>?;
            if (rawList != null) {
              foundAnnouncements = rawList.map((item) {
                final map = item as Map<String, dynamic>;
                final rowAnnouncement = RowAnnouncementModel.fromMap(map);
                // print("This is the rowAnnaounment: ${rowAnnouncement.message}");
                return AnnouncementModel(
                  message: rowAnnouncement.message,
                  date: rowAnnouncement.date,
                  rowCourseModel: rowCourse,
                );
              }).toList();
            }
          }

          // --- BLOCK 3: ASSESSMENT ---
          if (getAssessment) {
            //  print("In side the Assessment");
            final assessmentQuery = await courseRef
                .collection('section')
                .doc(sectionId)
                .collection('assessment')
                .get();

            if (assessmentQuery.docs.isNotEmpty) {
              try {
                foundAssessments = assessmentQuery.docs.map((doc) {
                  final data = doc.data();
                  print("This is the rowAssessment doc: $doc");
                  final rowAssessment = RowAssessmentModel.fromJson(
                    data,
                    studentId,
                  );

                  return AssessmentModel(
                    assessment: rowAssessment.assessment,
                    link: rowAssessment.link,
                    syllabus: rowAssessment.syllabus,
                    rowCourseModel: rowCourse,
                    result: (rowAssessment.result).toDouble(),
                    startTime: rowAssessment.startTime,
                    endTime: rowAssessment.endTime,
                    instructor: rowAssessment.instructor.toList(),
                    room: rowAssessment.room,
                  );
                }).toList();
              } catch (e) {
                // print("This is the e: $e");
              }
            }
          }
        }

        // Return mini-model for this course
        return SectionsuperModel(
          //   schedules: foundSchedule != null ? [foundSchedule] : [],
          schedules: foundSchedules,
          announcements: foundAnnouncements,
          assessment: foundAssessments,
        );
      });

      // 2. Wait for all
      final results = await Future.wait(courseFutures);

      // 3. Aggregate results
      List<ClassscheduleModel> allSchedules = [];
      List<AnnouncementModel> allAnnouncements = [];
      List<AssessmentModel> allAssessments = [];

      for (var result in results) {
        if (result.schedules != null) allSchedules.addAll(result.schedules!);
        if (result.announcements != null)
          allAnnouncements.addAll(result.announcements!);
        if (result.assessment != null)
          allAssessments.addAll(result.assessment!);
      }

      // 4. Sorting
      if (getAnnouncement) {
        allAnnouncements.sort((a, b) => b.date.compareTo(a.date));
      }

      // SORT ASSESSMENTS BY DATE (Newest First)
      if (getAssessment) {
        allAssessments.sort((a, b) => b.startTime.compareTo(a.startTime));
      }

      return SectionsuperModel(
        schedules: allSchedules,
        announcements: allAnnouncements,
        assessment: allAssessments,
      );
    } catch (e) {
      return SectionsuperModel(
        schedules: [],
        announcements: [],
        assessment: [],
      );
    }
  }
}
