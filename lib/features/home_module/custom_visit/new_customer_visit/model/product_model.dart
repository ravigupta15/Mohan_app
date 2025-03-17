class ProductModel {
  List<ProductItems>? data;

  ProductModel({this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductItems>[];
      json['data'].forEach((v) {
        data!.add( ProductItems.fromJson(v));
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

class ProductItems {
  dynamic productName;
  int quantity =0;
  bool isSelected=false;

  ProductItems({this.productName});

  ProductItems.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['product_name'] = productName;
    return data;
  }
}
