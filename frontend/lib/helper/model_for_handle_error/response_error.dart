class ResponseError {
  bool? status;
  String? message;

  ResponseError({this.status, this.message});

  ResponseError.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['messages'] = this.message;
    return data;
  }
}
