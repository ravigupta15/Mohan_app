class ProductItemModel {
  List<ProductItem>? data;

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
  String seletedCompetitor = '';
  int quantity =0;
  bool isSelected=false;
  String productType = '';
  String productCategory = '';

  ProductItem({this.name});

  ProductItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    return data;
  }
}
