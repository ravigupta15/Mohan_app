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
   String? name;
  String? customerName;
  String? verificType;
  String? customerLevel;
  String? shop;
  String? shopName;
  String? channelPartner;
  List<String>? contact;

  CustomerDetails({this.name,
      this.customerName,
      this.verificType,
      this.customerLevel,
      this.shop,
      this.shopName,
      this.channelPartner,
      this.contact});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    customerName = json['customer_name'];
    verificType = json['verific_type'];
    customerLevel = json['customer_level'];
    shop = json['shop'];
    shopName = json['shop_name'];
    channelPartner = json['channel_partner'];
    if (json['contact'] != null) {
      contact = List<String>.from(json['contact']);
    } 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
     data['name'] = name;
    data['customer_name'] = customerName;
    data['verific_type'] = verificType;
    data['customer_level'] = customerLevel;
    data['shop'] = shop;
    data['shop_name'] = shopName;
    data['channel_partner'] = channelPartner;
    data['contact'] = contact;
    return data;
  }
}
