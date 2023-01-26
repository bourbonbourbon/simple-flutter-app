class Records {
  int? id;
  String? name;
  String? email;
  String? address;
  String? phone;

  Records.fromMap(Map<String, dynamic> map) {
    id = map['_id'];
    name = map['name'];
    email = map['email'];
    address = map['address'];
    phone = map['phone'];
  }
}
