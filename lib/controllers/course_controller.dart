import 'package:course_guide/Models/course.dart';
import 'package:course_guide/Models/subject.dart';
import 'package:course_guide/controllers/subject_controller.dart';
import 'package:course_guide/db/db_courses.dart';
import 'package:get/get.dart';

class CourseController extends GetxController{
  @override
  void onReady(){
    super.onReady();
  }
  var courseList = <Course>[].obs;
  var searchedList = <Course>[].obs;
  final _subjectController = Get.put(SubjectController());
  Future<int> addCourse({Course? course}) async{
    return await courseDBHelper.insert(course);
  }
  Future<void> searchCourses() async{
    int points = calculatePoints();
    List<Map<String,dynamic>> subject = await courseDBHelper.search(points);
    searchedList.assignAll(subject.map((data)=> new Course.fromJson(data)).toList());
  }
  Future<void> getCourses() async{
    List<Map<String,dynamic>> subject = await courseDBHelper.query();
    courseList.assignAll(subject.map((data)=> new Course.fromJson(data)).toList());
  }
  void delete(Course course){
    courseDBHelper.delete(course);
  }
  Future<void> populate() async {
    print("inserting");
    int val = await addCourse(
        course: Course(
          name: "National Diploma in Consumer Science: Food and Nutrition",
          description: "A Senior Certificate or equivalent qualification with a minimum of: E – symbol or (3-4)(HG) in English (Second Language) D – symbol (SG) or (3-4)E – symbol (HG) in Life Sciences/Biology and D – symbol (SG) or (3-4)E – symbol (HG) in Physical Sciences",
          point: 28,
          color: 0,
        )
    );
    int val2 = await addCourse(
        course: Course(
          name: "National Diploma in Information Technology",
          description: "A Senior Certificate or equivalent qualification with a minimum of: E – symbol or (3-4)(HG) in English (Second Language) D – symbol (SG) or (3-4)E – symbol (HG) in Life Sciences/Biology and D – symbol (SG) or (3-4)E – symbol (HG) in Physical Sciences",
          point: 27,
          color: 1,
        )
    );
    int val3 = await addCourse(
        course: Course(
            name: "National Diploma in Information Technology: extended",
            description: "A Senior Certificate or equivalent qualification with a minimum of: E – symbol or (3-4)(HG) in English (Second Language) D – symbol (SG) or (3-4)E – symbol (HG) in Life Sciences/Biology and D – symbol (SG) or (3-4)E – symbol (HG) in Physical Sciences",
            point: 25,
            color: 2
        )
    );
    int val4 = await addCourse(
        course: Course(
          name: "National Diploma in Analytical Chemistry",
          description: "A Senior Certificate or equivalent qualification with a minimum of: E – symbol or (3-4)(HG) in English (Second Language) D – symbol (SG) or (3-4)E – symbol (HG) in Life Sciences/Biology and D – symbol (SG) or (3-4)E – symbol (HG) in Physical Sciences",
          point: 29,
          color: 0,
        )
    );
    int val5 = await addCourse(
        course: Course(
          name: "National Diploma in Analytical Chemistry:extended",
          description: "A Senior Certificate or equivalent qualification with a minimum of: E – symbol or (3-4)(HG) in English (Second Language) D – symbol (SG) or (3-4)E – symbol (HG) in Life Sciences/Biology and D – symbol (SG) or (3-4)E – symbol (HG) in Physical Sciences",
          point: 27,
          color: 1,
        )
    );
  }
  Future<int> updateSubject({Course? course}) async{
    return await courseDBHelper.subjectUpdate(course);
  }
  int calculatePoints() {
    int aps =0;
    for(int i=0;i<=_subjectController.subjectList.length-1;i++){
      Subject subject = _subjectController.subjectList[i];
      aps = aps + subject.point!.toInt();
    }
    return aps;
  }
}