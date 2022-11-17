import 'package:course_guide/Models/subject.dart';
import 'package:course_guide/controllers/subject_controller.dart';
import 'package:course_guide/widgets/add_subjects.dart';
import 'package:course_guide/widgets/components/my_buttons.dart';
import 'package:course_guide/widgets/components/my_tile.dart';
import 'package:course_guide/widgets/course.dart';
import 'package:course_guide/widgets/edit_subject.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:course_guide/widgets/components/styling.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:course_guide/controllers/course_controller.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _subjectController = Get.put(SubjectController());
  final _courseController = Get.put(CourseController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subjectController.getSubject();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _appTaskBar(),
          SizedBox(height: 10,),
          _showSubjects(),
        ],
      ),
      floatingActionButton: MyButton(
          label: "+ Add Subject",
          onTap: () async {
            await Get.to(()=>SubjectAdd());
            await _subjectController.getSubject();
          }),
    );
  }
  _countSubjects(){
    _subjectController.getSubject();
    int num = _subjectController.subjectList.length;
    if (num > 0){
      Get.to(()=>Courses());
    }else if(num<7){
      Get.snackbar("Error", "Number of captured subject must be more than 6!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.red,
          icon: Icon(Icons.error_outline,color: Colors.red,)
      );
    }else{
      Get.snackbar("Error", "No subject captured!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.red,
          icon: Icon(Icons.error_outline,color: Colors.red,)
      );
    }
  }
  _appTaskBar(){
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text("Today",style: headingStyle,)
              ],
            ),
          ),
          MyButton(label: "Get Courses",onTap:(){
            _countSubjects();
          }),
        ],
      ),
    );
  }
  _showSubjects(){
    return Expanded(
      child:Obx((){
        return ListView.builder(
            itemCount: _subjectController.subjectList.length,
            itemBuilder: (_,index) {
              _subjectController.getSubject();
              Subject subject = _subjectController.subjectList[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, subject);
                            },
                            child: TaskTile(subject),
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
  _showBottomSheet(BuildContext context,Subject subject){
    Get.bottomSheet(
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 4),
            height: MediaQuery.of(context).size.height*0.32,
            color: darkGreyClr,
            child: Column(
              children: [
                Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300],

                  ),
                ),
                Spacer(),
                _bottomSheetButton(
                  label: "Edit Subject",
                  onTap: (){
                    Get.to(()=>EditSubject(subject: subject,));
                  },
                  context: context,
                  clr: yellowClr,
                ),
                _bottomSheetButton(
                  label: "Delete Subject",
                  onTap: (){
                    _subjectController.delete(subject);
                    _subjectController.getSubject();
                    Get.back();
                  },
                  context: context,
                  clr: Colors.red[300]!,
                ),
                SizedBox(height: 10,),
                _bottomSheetButton(
                  label:"Close",
                  onTap: (){
                    Get.back();
                  },
                  isClose: true,
                  context: context,
                  clr: Colors.red[300]!,
                ),
                Spacer(),
              ],
            ),
          ),
        )
    );
  }
  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    required BuildContext context,
    bool isClose=false
  }){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 40,
        width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose==true?Get.isDarkMode?Colors.black:Colors.grey[300]!:clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose==true?Colors.grey[300]:clr,
        ),
        child: Center(
            child: Text(label,style: isClose?labelStyle:labelStyle.copyWith(color: Colors.white),)
        ),
      ),
    );
  }
  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor:Colors.black,
      leading:CircleAvatar(
        backgroundImage: AssetImage("img/logo.png"),
      ),
      title:  Text("Course Guide",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
      actions: [
        PopupMenuButton(
            icon: Icon(Icons.person,
              size: 30,
              color: Colors.white,),
            itemBuilder: (context){
              return[
                PopupMenuItem<int>(
                  value: 0,
                  child: IconButton(icon: Icon(Icons.logout,
                    size: 25,
                    color: Colors.black,
                  ),
                    onPressed: () {
                      SystemNavigator.pop();
                    },),
                ),
              ];
            }
        ),
        SizedBox(width: 20,),
      ],
    );
  }
}
