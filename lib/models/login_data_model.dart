class LoginModel {
  Business? business;
  Brand? brand;
  Token? token;

  LoginModel({this.business, this.brand, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    business =
        json['business'] != null ? Business.fromJson(json['business']) : null;
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    token = json['token'] != null ? Token.fromJson(json['token']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (business != null) {
      data['business'] = business!.toJson();
    }
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    if (token != null) {
      data['token'] = token!.toJson();
    }
    return data;
  }
}

class Business {
  String? sId;
  String? businessName;
  bool? active;
  String? externalId;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? ownerID;

  Business(
      {this.sId,
      this.businessName,
      this.active,
      this.externalId,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.ownerID});

  Business.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    businessName = json['businessName'];
    active = json['active'];
    externalId = json['externalId'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    ownerID = json['ownerID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['businessName'] = businessName;
    data['active'] = active;
    data['externalId'] = externalId;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['ownerID'] = ownerID;
    return data;
  }
}

class Brand {
  String? sId;
  String? name;
  String? phone;
  String? email;
  String? image;
  String? externalId;
  String? businessId;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? fcmToken;

  Brand(
      {this.sId,
      this.name,
      this.phone,
      this.email,
      this.image,
      this.externalId,
      this.businessId,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.fcmToken});

  Brand.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    externalId = json['externalId'];
    businessId = json['businessId'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    fcmToken = json['fcmToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['image'] = image;
    data['externalId'] = externalId;
    data['businessId'] = businessId;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['fcmToken'] = fcmToken;
    return data;
  }
}

class Token {
  String? token;
  String? refreshToken;

  Token({this.token, this.refreshToken});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    return data;
  }
}
