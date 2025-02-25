class ItemModel {
  List<Items>? data;
  List<Items> selectedList = [];

  ItemModel({this.data});

  ItemModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Items>[];
      json['data'].forEach((v) {
        data!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? name;
  String? itemName;
  String seletedCompetitor = '';
  int quantity =0;
  bool isSelected=false;
  String productType = '';
  String productCategory = '';
  String? itemCode;

  Items({this.name, this.itemCode, this.itemName});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['item_code'] = itemCode;
    data['item_name']=itemName;
    return data;
  }
}


class ProductSendModel{
  String productType = '';
  List<Items> list = [];

  ProductSendModel({
    required this.list,
    required this.productType
  });
}