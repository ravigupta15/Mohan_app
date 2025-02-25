class CustomerInfoModel {
  List<CustomerDetails>? message;

  CustomerInfoModel({this.message});

  CustomerInfoModel.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = <CustomerDetails>[];
      json['message'].forEach((v) {
        message!.add( CustomerDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (message != null) {
      data['message'] = message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerDetails {
  dynamic customer;
  dynamic customerName;
  dynamic shop;
  List<String>? contact;

  CustomerDetails({this.customer, this.customerName, this.shop, this.contact});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    customer = json['customer']??'';
    customerName = json['customer_name']??'';
    shop = json['shop']??"";
    contact = json['contact'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['customer'] = customer;
    data['customer_name'] = customerName;
    data['shop'] = shop;
    data['contact'] = contact;
    return data;
  }
}
