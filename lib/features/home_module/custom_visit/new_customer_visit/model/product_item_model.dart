class ProductItemModel {
  List<ProductItem>? data;
  List<ProductItem> selectedList = [];
  ProductItemModel({this.data});

  ProductItemModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductItem>[];
      json['data'].forEach((v) {
        data!.add( ProductItem.fromJson(v));
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

class ProductItem {
  dynamic name;
  dynamic itemCode;
  dynamic uom;
  String seletedCompetitor = '';
  int quantity =0;
  bool isSelected=false;
  String productType = '';
  String productCategory = '';

  ProductItem(
    this.seletedCompetitor,
    this.quantity,
    this.uom,
    this.isSelected,
    this.productCategory,
    this.productType,
    this.name, 
    this.itemCode);

  ProductItem.fromJson(Map<String, dynamic> json) {
    name = json['item_name'];
    itemCode = json['item_code'];
    uom = json['uom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['item_code'] = itemCode;
    data['uom'] = uom;
    return data;
  }
}

  class ProductSendModel{
    String productType = '';
    List<ProductItem> list = [];

    ProductSendModel({
      required this.list,
      required this.productType
    });
  }