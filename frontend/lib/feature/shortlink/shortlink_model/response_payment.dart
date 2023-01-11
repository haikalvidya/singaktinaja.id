class ResponsePaymentPaket {
  bool? status;
  String? messages;
  Data? data;

  ResponsePaymentPaket({this.status, this.messages, this.data});

  ResponsePaymentPaket.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['messages'] = this.messages;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  String? paymentId;
  String? jenisPaketId;
  String? status;
  String? startDate;
  String? endDate;
  String? urlPayment;
  String? createdAt;

  Data(
      {this.id,
      this.userId,
      this.paymentId,
      this.jenisPaketId,
      this.status,
      this.startDate,
      this.endDate,
      this.urlPayment,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    paymentId = json['payment_id'];
    jenisPaketId = json['jenis_paket_id'];
    status = json['status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    urlPayment = json['url_payment'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['payment_id'] = this.paymentId;
    data['jenis_paket_id'] = this.jenisPaketId;
    data['status'] = this.status;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['url_payment'] = this.urlPayment;
    data['created_at'] = this.createdAt;
    return data;
  }
}
