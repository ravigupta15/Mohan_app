class MaterialItemsModel {
  dynamic status;
  dynamic message;
  List<MaterialItems>? data;

  MaterialItemsModel({this.status, this.message, this.data});

  MaterialItemsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MaterialItems>[];
      json['data'].forEach((v) {
        data!.add( MaterialItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MaterialItems {
  dynamic itemCode;
  dynamic itemName;
  int quantity =0;
  bool isSelected=false;

  MaterialItems({this.itemCode, this.itemName});

  MaterialItems.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemName = json['item_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['item_code'] = itemCode;
    data['item_name'] = itemName;
    return data;
  }
}
