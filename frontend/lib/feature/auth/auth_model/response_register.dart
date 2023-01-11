class ResponseRegistrasi {
  bool? status;
  String? messages;
  Data? data;

  ResponseRegistrasi({this.status, this.messages, this.data});

  ResponseRegistrasi.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['messages'] = messages;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  UserInfo? userInfo;
  String? token;

  Data({this.userInfo, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    userInfo =
        json['user_info'] != null ? UserInfo.fromJson(json['user_info']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userInfo != null) {
      data['user_info'] = userInfo!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class UserInfo {
  String? id;
  String? firstName;
  String? lastName;
  String? email;

  UserInfo({this.id, this.firstName, this.lastName, this.email});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    return data;
  }
}
