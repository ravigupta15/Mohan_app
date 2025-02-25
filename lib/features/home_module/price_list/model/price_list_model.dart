class PriceListModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  PriceListModel({this.status, this.message, this.data});

  PriceListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
   dynamic itemCode;
  dynamic itemName;
  dynamic itemCategory;
  dynamic priceListRate;
  Data({this.itemCategory, this.itemCode, this.itemName, this.priceListRate});

  Data.fromJson(Map<String, dynamic> json) {
   itemCode = json['item_code'];
    itemName = json['item_name'];
    itemCategory = json['item_category'];
    priceListRate = json['price_list_rate'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
     data['item_code'] = itemCode;
    data['item_name'] = itemName;
    data['item_category'] = itemCategory;
    data['price_list_rate'] = priceListRate;
    return data;
  }
}
