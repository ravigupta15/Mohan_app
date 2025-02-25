class DigitalMarkingModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  DigitalMarkingModel({this.status, this.message, this.data});

  DigitalMarkingModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic name;
  dynamic productName;
  dynamic productAttachment;

  Data({this.name, this.productName, this.productAttachment});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    productName = json['product_name'];
    productAttachment = json['product_attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['product_name'] = productName;
    data['product_attachment'] = productAttachment;
    return data;
  }
}
