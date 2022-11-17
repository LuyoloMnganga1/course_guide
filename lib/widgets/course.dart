import 'package:course_guide/Models/course.dart';
import 'package:course_guide/controllers/course_controller.dart';
import 'package:course_guide/widgets/components/course_tile.dart';
import 'package:course_guide/widgets/components/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  final _courseController = Get.put(CourseController());
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
     _courseController.populate();
     _courseController.getCourses();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 10,),
          _appTaskBar(),
          SizedBox(height: 10,),
          _showCourses(),
        ],
      ),
    );
  }
  _appTaskBar(){
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Admission Point ",
                  style: subHeadingStyle,
                ),
                Text("Score",
                  style: subHeadingStyle,
                ),
              ],
            ),
          ),
          Text(_courseController.calculatePoints().toString(),style: headingStyle,)

        ],
      ),
    );
  }
  _showCourses(){
    return Expanded(
      child:Obx((){
        return ListView.builder(
            itemCount: _courseController.courseList.length,
            itemBuilder: (_,index) {
              _courseController.getCourses();
              Course course = _courseController.courseList[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: ()=>null,
                          child: CourseTile(course),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
        );
      }),
    );
  }
  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor:Colors.black,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back_sharp,size: 30,color: Colors.white,),
      ),
      title:  Text("Course Guide",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
      actions: [
        PopupMenuButton(
            icon: Icon(Icons.person,
              size: 30,
              color: Colors.white,),
            itemBuilder: (context){
              return[];
            }
        ),
        SizedBox(width: 20,),
      ],
    );
  }
}
