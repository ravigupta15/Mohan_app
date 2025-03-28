class ItemTemplateModel {
  dynamic status;
  dynamic message;
  List<ItemVariant>? data;
  List<ItemVariant> selectedList = [];

  ItemTemplateModel({this.status, this.message, this.data});

  ItemTemplateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ItemVariant>[];
      json['data'].forEach((v) {
        data!.add( ItemVariant.fromJson(v));
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

class ItemVariant {
  dynamic itemCode;
  dynamic itemName;
  int quantity =0;
  bool isSelected=false;
  String itemTempate = '';
  String seletedCompetitor = '';
  List<String>? competitors;
  dynamic uom;
  dynamic itemCategory;

  ItemVariant(this.itemCode, this.itemName, this.quantity, this.isSelected, this.itemTempate,  this.seletedCompetitor,
  this.competitors, this.uom, this.itemCategory);

  ItemVariant.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemName = json['item_name'];
    uom = json['uom'];
    itemCategory = json['item_category'];
      competitors = json['competitors'] != null && json['competitors'] is List
      ? List<String>.from(json['competitors']) 
      : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['item_code'] = itemCode;
    data['item_name'] = itemName;
    data['competitors'] = competitors;
    data['uom']  = uom;
    data['item_category'] = itemCategory;
    return data;
  }
}

class SalesItemVariantSendModel{
  String itemTemplate = '';
  List<ItemVariant> list = [];

  SalesItemVariantSendModel({
    required this.list,
    required this.itemTemplate
  });
}