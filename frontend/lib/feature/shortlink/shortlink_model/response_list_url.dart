class ResponseGetListUrl {
  bool? status;
  String? messages;
  List<Data>? data;

  ResponseGetListUrl({this.status, this.messages, this.data});

  ResponseGetListUrl.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['messages'] = messages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? shortUrl;
  String? longUrl;
  String? name;
  int? clicks;
  bool? isCostum;
  String? createdAt;

  Data(
      {this.id,
      this.shortUrl,
      this.longUrl,
      this.name,
      this.clicks,
      this.isCostum,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shortUrl = json['short_url'];
    longUrl = json['long_url'];
    name = json['name'];
    clicks = json['clicks'];
    isCostum = json['is_costum'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['short_url'] = shortUrl;
    data['long_url'] = longUrl;
    data['name'] = name;
    data['clicks'] = clicks;
    data['is_costum'] = isCostum;
    data['created_at'] = createdAt;
    return data;
  }
}
