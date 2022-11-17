class Course{
  int? id;
  String? name;
  String? description;
  int? point;
  int? color;

  Course({
    this.id,
    this.name,
    this.description,
    this.point,
    this.color,

  });
  Course.fromJson(Map<String, dynamic>json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    point = json['point'];
    color = json['color'];
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['point'] = this.point;
    data['color'] = this.color;
    return data;
  }

}