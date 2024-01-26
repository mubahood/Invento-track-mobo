class LoggedInUser {
  int id = 0;
  String username = "";
  String password = "";
  String name = "";
  String avatar = "";
  String remember_token = "";
  String created_at = "";
  String updated_at = "";
  String company_id = "";
  String first_name = "";
  String last_name = "";
  String phone_number = "";
  String phone_number_2 = "";
  String address = "";
  String sex = "";
  String dob = "";
  String status = "";
  String email = "";

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'name': name,
      'avatar': avatar,
      'remember_token': remember_token,
      'created_at': created_at,
      'updated_at': updated_at,
      'company_id': company_id,
      'first_name': first_name,
      'last_name': last_name,
      'phone_number': phone_number,
      'phone_number_2': phone_number_2,
      'address': address,
      'sex': sex,
      'dob': dob,
      'status': status,
      'email': email,
    };
  }

  static LoggedInUser fromJson(data) {
    if (data == null) {
      return LoggedInUser();
    }
    if (data.runtimeType.toString().contains('map')) {
      return LoggedInUser();
    }

    LoggedInUser obj = LoggedInUser();
    obj.id = int.parse(data['id'].toString());
    obj.username = data['username'].toString();
    obj.password = data['password'].toString();
    obj.name = data['name'].toString();
    obj.avatar = data['avatar'].toString();
    obj.remember_token = data['remember_token'].toString();
    obj.created_at = data['created_at'].toString();
    obj.updated_at = data['updated_at'].toString();
    obj.company_id = data['company_id'].toString();
    obj.first_name = data['first_name'].toString();
    obj.last_name = data['last_name'].toString();
    obj.phone_number = data['phone_number'].toString();
    obj.phone_number_2 = data['phone_number_2'].toString();
    obj.address = data['address'].toString();
    obj.sex = data['sex'].toString();
    obj.dob = data['dob'].toString();
    obj.status = data['status'].toString();
    obj.email = data['email'].toString();

    return obj;
  }
}
