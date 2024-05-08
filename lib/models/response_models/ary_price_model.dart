class AryPriceModel {
  String? sell;
  String? buy;

  AryPriceModel(
      {this.sell,
        this.buy,
        });

  AryPriceModel.fromJson(Map<String, dynamic> json) {
    sell = json['sell'];
    buy = json['buy'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sell'] = sell;
    data['buy'] = buy;
    return data;
  }
}
