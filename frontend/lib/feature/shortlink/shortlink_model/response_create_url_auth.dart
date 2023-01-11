class ResponseCreateShortUrlAuth {
  bool? status;
  String? messages;
  Data? data;

  ResponseCreateShortUrlAuth({this.status, this.messages, this.data});

  ResponseCreateShortUrlAuth.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['short_url'] = this.shortUrl;
    data['long_url'] = this.longUrl;
    data['name'] = this.name;
    data['clicks'] = this.clicks;
    data['is_costum'] = this.isCostum;
    data['created_at'] = this.createdAt;
    return data;
  }
}
