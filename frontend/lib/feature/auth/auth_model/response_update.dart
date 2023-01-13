class ResponseUpdateUser {
  bool? status;
  String? messages;

  ResponseUpdateUser({this.status, this.messages});

  ResponseUpdateUser.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['messages'] = messages;
    return data;
  }
}
