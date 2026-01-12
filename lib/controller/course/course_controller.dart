import 'package:academicpanel/model/Announcement/announcement_model.dart';
import 'package:academicpanel/model/Announcement/row_announcement_model.dart';
import 'package:academicpanel/model/ClassSchedule/classSchedule_model.dart';
import 'package:academicpanel/model/assessment/assessment_model.dart';
import 'package:academicpanel/model/assessment/row_assessment_model.dart';
import 'package:academicpanel/model/courseSuperModel/row_course_model.dart';
import 'package:academicpanel/model/courseSuperModel/sectionSuper_model.dart';
import 'package:academicpanel/model/user/user_model.dart';
import 'package:academicpanel/network/save_data/firebase/fireBase_DataPath.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CourseController extends GetxController {
  final FirebaseDatapath firebaseDatapath = FirebaseDatapath();

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
        ClassscheduleModel? foundSchedule;
        List<AnnouncementModel> foundAnnouncements = [];
        List<AssessmentModel> foundAssessments = []; // <--- Temp List

        if (infoSnapshot.exists && sectionSnapshot.exists) {
          final infoData = infoSnapshot.data() ?? {};
          final secData = sectionSnapshot.data() ?? {};

          // final courseName = infoData['name'] ?? '';
          // final courseCodeStr = infoData['code'] ?? courseCode;
          // final courseCredit = infoData['credit'] ?? 0;

          // Create the Course Info Model once
          // final rowCourse = RowCourseModel(
          //   name: courseName,
          //   code: courseCodeStr,
          //   credit: courseCredit
          // );
          final rowCourse = RowCourseModel.fromMap(infoData);

          // --- BLOCK 1: SCHEDULE ---
          if (getClassSchedule) {
            final now = DateTime.now();
            final days = ['mo', 'tu', 'we', 'th', 'fr', 'sa', 'su'];
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

          // --- BLOCK 3: ASSESSMENT (FIXED) ---
          if (getAssessment) {
            print("In side the Assessment");
            final assessmentQuery = await courseRef
                .collection('section')
                .doc(sectionId)
                .collection('assessment')
                .get();

            print(assessmentQuery);

            if (assessmentQuery.docs.isNotEmpty) {
              // 2. Loop through each assessment document (e.g., "Quiz 1")
              foundAssessments = assessmentQuery.docs.map((doc) {
                final data = doc.data();

                final rowAssessment = RowAssessmentModel.fromMap(
                  data,
                  studentId,
                );
                print("This is the rowAssessment: ${rowAssessment.assessment}");

                return AssessmentModel(
                  assessment: rowAssessment.assessment,
                  date: rowAssessment.date,

                  link: rowAssessment.link,
                  syllabus: rowAssessment.syllabus,

                  // Pass the course info wrapper
                  rowCourseModel: rowCourse,

                  // OPTIONAL: If you want to store the result in the model:
                  // myScore: (myResult ?? 0).toDouble(),
                );
              }).toList();
            }
          }
        }

        // Return mini-model for this course
        return SectionsuperModel(
          schedules: foundSchedule != null ? [foundSchedule] : [],
          announcements: foundAnnouncements,
          assessment: foundAssessments, // <--- Add to return
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
        allAssessments.sort((a, b) => b.date.compareTo(a.date));
      }

      return SectionsuperModel(
        schedules: allSchedules,
        announcements: allAnnouncements,
        assessment: allAssessments,
      );
    } catch (e) {
      print("Error fetching data: $e");
      return SectionsuperModel(
        schedules: [],
        announcements: [],
        assessment: [],
      );
    }
  }
}

// class CourseController extends GetxController {
//   final FirebaseDatapath firebaseDatapath = FirebaseDatapath();
//   Future<SectionsuperModel> fetchSectionData({
//     required UserModel userModel,
//     bool getAssessment = false,
//     bool getClassSchedule = false,
//     bool getAnnouncement = false,
//   }) async {
//     try {
//       final id = userModel.id;
//       final department = userModel.department;
//       final courses = userModel.current_course ?? {};

//       // 1. Loop through courses
//       final courseFutures = courses.entries.map((entry) async {
//         String courseCode = entry.key;
//         String sectionId = entry.value;

//         final courseRef = firebaseDatapath.courseData(department, courseCode);

//         // Fetch Data
//         final results = await Future.wait([
//           courseRef.get(),
//           courseRef.collection('section').doc(sectionId).get(),
//         ]);

//         final infoSnapshot = results[0];
//         final sectionSnapshot = results[1];

//         // Temp variables to hold what we find for THIS specific course
//         ClassscheduleModel? foundSchedule;
//         List<AnnouncementModel> foundAnnouncements = [];

//         if (infoSnapshot.exists && sectionSnapshot.exists) {
//           final infoData = infoSnapshot.data() ?? {};
//           final secData = sectionSnapshot.data() ?? {};
//           final courseName = infoData['name'] ?? courseCode;
//           final Code = infoData['code'] ?? courseCode;

//           // --- BLOCK 1: SCHEDULE ---
//           if (getClassSchedule) {
//             final now = DateTime.now();
//             final days = ['mo', 'tu', 'we', 'th', 'fr', 'sa', 'su'];

//             String dayKey = days[now.weekday - 1];

//             final scheduleMap = secData['schedule'] as Map<String, dynamic>?;

//             if (scheduleMap != null && scheduleMap.containsKey(dayKey)) {
//               foundSchedule = ClassscheduleModel.fromJoinedData(
//                 courseInfo: infoData,
//                 sectionData: secData,
//                 daySchedule: scheduleMap[dayKey],
//                 defaultCode: courseCode,
//               );
//             }
//           }

//           // --- BLOCK 2: ANNOUNCEMENTS ---
//           if (getAnnouncement) {
//             final rawList = secData['announcement'] as List<dynamic>?;

//             if (rawList != null) {
//               foundAnnouncements = rawList.map((item) {
//                 final map = item as Map<String, dynamic>;
//                 return AnnouncementModel(
//                   message: map['message'] ?? '',
//                   date: (map['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
//                   name: courseName,
//                   code: Code,
//                 );
//               }).toList();
//             }
//           }
//           if (getAssessment) {
//             final assessmentDoc = await courseRef
//                 .collection('section')
//                 .doc(sectionId)
//                 .collection('assessment')
//                 .doc(id)
//                 .get();
//             final rowAssessmentList = assessmentDoc.exists
//                 ? RowAssessmentModel.fromMap(assessmentDoc.data() ?? {}, id)
//                 : null;
//           }

//         }

//         // Return a mini-model for just this one course
//         return SectionsuperModel(
//           schedules: foundSchedule != null ? [foundSchedule] : [],
//           announcements: foundAnnouncements,
//           assessment: 
//         );
//       });

//       // 2. Wait for all courses to finish
//       final results = await Future.wait(courseFutures);

//       // 3. Aggregate (Combine) the results
//       List<ClassscheduleModel> allSchedules = [];
//       List<AnnouncementModel> allAnnouncements = [];
//       List<AssessmentModel> allAssessment = [];


//       for (var result in results) {
//         if (result.schedules != null) {
//           allSchedules.addAll(
//             result.schedules! as Iterable<ClassscheduleModel>,
//           );
//         }
//         if (result.announcements != null) {
//           allAnnouncements.addAll(result.announcements!);
//         }
//       }

//       // 4. Sort Announcements (Newest first)
//       if (getAnnouncement) {
//         allAnnouncements.sort((a, b) => b.date.compareTo(a.date));
//       }

//       // 6. Return the final Super Model

//       return SectionsuperModel(
//         schedules: allSchedules,
//         announcements: allAnnouncements,
//         assessment: allAssessment

//       );
//     } catch (e) {
//       print("Error fetching data: $e");
//       return SectionsuperModel(schedules: [], announcements: []);
//     }
//   }
// }
