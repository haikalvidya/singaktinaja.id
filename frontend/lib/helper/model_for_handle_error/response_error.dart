class ResponseError {
  bool? status;
  String? message;

  ResponseError({this.status, this.message});

  ResponseError.fromJson(Map<String, dynamic> json) {
    message = json['messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messages'] = this.message;
    return data;
  }
}
