import 'package:course_guide/Models/subject.dart';
import 'package:course_guide/controllers/subject_controller.dart';
import 'package:course_guide/widgets/components/my_buttons.dart';
import 'package:course_guide/widgets/components/my_inpufield.dart';
import 'package:flutter/material.dart';
import 'package:course_guide/widgets/components/styling.dart';
import 'package:get/get.dart';
class SubjectAdd extends StatefulWidget {
  const SubjectAdd({Key? key}) : super(key: key);

  @override
  State<SubjectAdd> createState() => _SubjectAddState();
}

class _SubjectAddState extends State<SubjectAdd> {
  final _subjectController = Get.put(SubjectController());
  TextEditingController _nameController = TextEditingController();
  String _selectedPercent = "0-29";
  int _selectedColor = 0;
  List<String> percentList = ["0-29","30-39","40-49","50-59","60-69","70-79","80-89","90-100"];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Text("APS Calculator",
                style: headingStyle,
              ),
              MyInputField(title: "Subject Name", hint: "Enter your subject",controller: _nameController,),
              MyInputField(title: "Subject %", hint: _selectedPercent,
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subLabelStyle,
                  underline: Container(height: 0,),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPercent = newValue!;
                    });
                  },
                  items: percentList.map<DropdownMenuItem<String>>((String? value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value!,style: TextStyle(color: Colors.grey),),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorPanel(),
                  MyButton(label: 'Add',
                    onTap: () {
                      _validateData();
                    },
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  _validateData() async {
    if(_nameController.text.isNotEmpty){
      _addSubjectToDB();
      await _subjectController.getSubject();
      Get.back();
    }else if(_nameController.text.isEmpty){
      Get.snackbar("Required", "All field are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.red,
          icon: Icon(Icons.warning_amber_outlined,color: Colors.red,)
      );
    }
  }

  _addSubjectToDB() async {
    int  value = await _subjectController.addSubject(
        subject: Subject(
          name: _nameController.text.toUpperCase(),
          percent: _selectedPercent,
          point: _getPoints(),
          color: _selectedColor,
        )
    );
  }
  _getPoints(){
    int points = 0;
    switch (_selectedPercent){
      case "0-29":
        if(_nameController.text.toLowerCase() == "life orientation"){
          points = 0;
        }else{
          points = 0;
        }
        break;
      case "30-39":
        if(_nameController.text.toLowerCase() == "life orientation"){
          points = 0;
        }else{
          points = 1;
        }
        break;
      case "40-49":
        if(_nameController.text.toLowerCase() == "life orientation"){
          points = 0;
        }else{
          points = 4;
        }
        break;
      case "50-59":
        if(_nameController.text.toLowerCase() == "life orientation"){
          points = 0;
        }else{
          points = 5;
        }
        break;
      case "60-69":
        if(_nameController.text.toLowerCase() == "life orientation"){
          points = 0;
        }else{
          points = 6;
        }
        break;
      case "70-79":
        if(_nameController.text.toLowerCase() == "life orientation"){
          points = 0;
        }else{
          points = 7;
        }
        break;
      case "80-89":
        if(_nameController.text.toLowerCase() == "life orientation"){
          points = 0;
        }else{
          points = 8;
        }
        break;
      case "90-100":
        if(_nameController.text.toLowerCase() == "life orientation"){
        points = 1;
        }else{
        points = 9;
        }
        break;
      default:
        points = 0;
        break;
    }
    return points;
  }
  _colorPanel(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color",style: labelStyle,),
        SizedBox(height: 8.0,),
        Wrap(
          children:List<Widget>.generate(
              3, (int index){
            return GestureDetector(
              onTap: (){
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index==0?primaryClr:index==1?pinkClr:yellowClr,
                  child: _selectedColor==index?Icon(Icons.done,
                    color: Colors.white,
                    size: 16,):Container(),
                ),
              ),
            );
          }) ,
        )

      ],
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
