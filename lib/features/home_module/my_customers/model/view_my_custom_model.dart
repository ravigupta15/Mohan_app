class ViewMyCustomerModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  ViewMyCustomerModel({this.status, this.message, this.data});

  ViewMyCustomerModel.fromJson(Map<String, dynamic> json) {
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
  dynamic name;
  dynamic customerName;
  dynamic shopName;
  Location? location;
  dynamic contact;
  dynamic outstandingAmt;
  dynamic lastBillingRate;

  Data(
      {this.name,
      this.customerName,
      this.shopName,
      this.location,
      this.contact,
      this.outstandingAmt,
      this.lastBillingRate});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    customerName = json['customer_name'];
    shopName = json['shop_name'];
     location = json['location'] != null
        ?  Location.fromJson(json['location'])
        : null;
    contact = json['contact'];
    outstandingAmt = json['outstanding_amt'];
    lastBillingRate = json['last_billing_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['customer_name'] = customerName;
    data['shop_name'] = shopName;
    if (this.location != null) {
      data['location'] = location!.toJson();
    }
    data['contact'] = contact;
    data['outstanding_amt'] = outstandingAmt;
    data['last_billing_rate'] = lastBillingRate;
    return data;
  }
}


class Location {
  dynamic name;
  dynamic addressTitle;
  dynamic addressLine1;
  dynamic addressLine2;
  dynamic city;
  dynamic state;
  dynamic pincode;

  Location(
      {this.name,
      this.addressTitle,
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.state,
      this.pincode});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    addressTitle = json['address_title'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['address_title'] = addressTitle;
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    data['city'] = city;
    data['state'] = state;
    data['pincode'] = pincode;
    return data;
  }

  
}