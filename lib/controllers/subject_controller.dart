import 'package:course_guide/Models/subject.dart';
import 'package:course_guide/db/db_helper.dart';
import 'package:get/get.dart';


class SubjectController extends GetxController{
  @override
  void onReady(){
    super.onReady();
  }
  var subjectList = <Subject>[].obs;
  Future<int> addSubject({Subject? subject}) async{
    return await DBHelper.insert(subject);
  }
  Future<void> getSubject() async{
    List<Map<String,dynamic>> subject = await DBHelper.query();
    subjectList.assignAll(subject.map((data)=> new Subject.fromJson(data)).toList());
  }
  void delete(Subject subject){
    DBHelper.delete(subject);
  }
  Future<int> calAps() async{
    int aps;
      aps = (await DBHelper.calculatePoints()) as int;
      return aps;
  }
  Future<int> searchSubject(String name) async{
    int search =0;
    var items = await DBHelper.search(name);
    items.isEmpty?search=0:search=1;
    return  search;
  }
  Future<int> updateSubject({Subject? subject}) async{
    return await DBHelper.subjectUpdate(subject);
  }

}