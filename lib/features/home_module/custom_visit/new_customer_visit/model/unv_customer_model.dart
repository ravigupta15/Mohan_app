class UNVCustomerModel {
  dynamic status;
  dynamic message;
  List<UNVModel>? data;

  UNVCustomerModel({this.status, this.message, this.data});

  UNVCustomerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UNVModel>[];
      json['data'].forEach((v) {
        data!.add( UNVModel.fromJson(v));
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

class UNVModel {
  dynamic name;
  dynamic customerName;
  dynamic shopName;
  dynamic address;
  dynamic addressTitle;
  dynamic addressLine1;
  dynamic addressLine2;
  dynamic district;
  dynamic state;
  dynamic pincode;
  List<String>? contact;

  UNVModel(
      {this.name,
      this.customerName,
      this.shopName,
      this.address,
      this.addressTitle,
      this.addressLine1,
      this.addressLine2,
      this.district,
      this.state,
      this.pincode,
      this.contact});

  UNVModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    customerName = json['customer_name'];
    shopName = json['shop_name'];
    address = json['address'];
    addressTitle = json['address_title'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    district = json['district'];
    state = json['state'];
    pincode = json['pincode'];
    contact = json['contact'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['customer_name'] = customerName;
    data['shop_name'] = shopName;
    data['address'] = address;
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    data['district'] = district;
    data['state'] = state;
    data['pincode'] = pincode;
    data['contact'] = contact;
    return data;
  }
}
