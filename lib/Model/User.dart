class User{
  String id;
  String name;
  User({this.id,this.name});


  Map<String, dynamic> toJson() =>
      {
        'id': this.id,
        'name': this.name,
      };
  fromJson(Map parsedJson) {
    id = parsedJson['id'] ?? '';
    name = parsedJson['name'] ?? '';
  }
}