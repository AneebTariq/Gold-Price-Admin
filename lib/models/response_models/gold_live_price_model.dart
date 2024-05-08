class GoldLivePriceModel {
  String? symbol;
  String? name;
  double? price;
  String? updatedAt;
  String? updatedAtReadable;

  GoldLivePriceModel(
      {this.symbol,
        this.name,
        this.price,
        this.updatedAt,
        this.updatedAtReadable});

  GoldLivePriceModel.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    name = json['name'];
    price = json['price'];
    updatedAt = json['updatedAt'];
    updatedAtReadable = json['updatedAtReadable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['symbol'] = symbol;
    data['name'] = name;
    data['price'] = price;
    data['updatedAt'] = updatedAt;
    data['updatedAtReadable'] = updatedAtReadable;
    return data;
  }
}
