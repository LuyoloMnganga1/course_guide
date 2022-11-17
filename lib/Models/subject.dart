class Subject{
  int? id;
  String? name;
  String? percent;
  int? point;
  int? color;

  Subject({
    this.id,
    this.name,
    this.percent,
    this.point,
    this.color,

  });
  Subject.fromJson(Map<String, dynamic>json){
    id = json['id'];
    name = json['name'];
    percent = json['percent'];
    point = json['point'];
    color = json['color'];
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['percent'] = this.percent;
    data['point'] = this.point;
    data['color'] = this.color;
    return data;
  }

}