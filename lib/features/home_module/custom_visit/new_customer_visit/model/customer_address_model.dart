class CustomerAddressModel {
  dynamic status;
  dynamic message;
  Data? data;

  CustomerAddressModel({this.status, this.message, this.data});

  CustomerAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic name;
  dynamic addressTitle;
  dynamic addressLine1;
  dynamic addressLine2;
  dynamic district;
  dynamic state;
  dynamic pincode;

  Data(
      {this.name,
      this.addressTitle,
      this.addressLine1,
      this.addressLine2,
      this.district,
      this.state,
      this.pincode});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    addressTitle = json['address_title'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    district = json['district'];
    state = json['state'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['address_title'] = addressTitle;
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    data['district'] = district;
    data['state'] = state;
    data['pincode'] = pincode;
    return data;
  }
}
