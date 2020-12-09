class User{
  String id;
  String name;
  User({this.id,this.name});


  Map<dynamic, dynamic> toJson() =>
      {
        'id': this.id,
        'name': this.name,
      };
  fromJson(Map parsedJson) {
    id = parsedJson['id'] ?? '';
    name = parsedJson['name'] ?? '';
  }
}