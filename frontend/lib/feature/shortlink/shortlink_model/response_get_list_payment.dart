class ResponseGetListPayment {
  bool? status;
  String? messages;
  List<Data>? data;

  ResponseGetListPayment({this.status, this.messages, this.data});

  ResponseGetListPayment.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['messages'] = this.messages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  int? amountTotal;
  String? status;
  String? expiredDate;
  String? paidAt;
  String? xenditRefId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.userId,
      this.amountTotal,
      this.status,
      this.expiredDate,
      this.paidAt,
      this.xenditRefId,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amountTotal = json['amount_total'];
    status = json['status'];
    expiredDate = json['expired_date'];
    paidAt = json['paid_at'];
    xenditRefId = json['xendit_ref_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amount_total'] = this.amountTotal;
    data['status'] = this.status;
    data['expired_date'] = this.expiredDate;
    data['paid_at'] = this.paidAt;
    data['xendit_ref_id'] = this.xenditRefId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
