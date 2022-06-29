class Player {
  String email;
  String password;
  String name;
  String phoneNumber;

  Player({this.email, this.password, this.name, this.phoneNumber});

  Player.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    return data;
  }
}
