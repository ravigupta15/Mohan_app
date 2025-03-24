import 'package:mohan_impex/features/home_module/kyc/model/activity_model.dart';

class ViewVisitModel {
  dynamic status;
  dynamic message;
  List<VisitItemsModel>? data;

  ViewVisitModel({this.status, this.message, this.data});

  ViewVisitModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <VisitItemsModel>[];
      json['data'].forEach((v) {
        data!.add( VisitItemsModel.fromJson(v));
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

class VisitItemsModel {
  dynamic name;
  dynamic customerType;
  dynamic customerLevel;
  dynamic verificType;
  dynamic unvCustomer;
  dynamic unvCustomerName;
  dynamic customer;
  dynamic customerName;
  dynamic channelPartner;
  dynamic kycStatus;
  dynamic dealType;
  dynamic latitude;
  dynamic longitude;
  dynamic hasTrialPlan;
  dynamic shop;
  dynamic shopName;
  dynamic status;
  dynamic location;
  dynamic addressTitle;
  dynamic addressLine1;
  dynamic addressLine2;
  dynamic district;
  dynamic state;
  dynamic pincode;
  dynamic appointmentDate;
  dynamic conductBy;
  dynamic trialType;
  dynamic mapLocation;
  dynamic remarksnotes;
  dynamic visitStart;
  dynamic visitEnd;
  dynamic visitDuration;
  dynamic workflowState;
  List<ProductPitching>? productPitching;
  List? productTrial;
  List? itemTrial;
  List<Contact>? contact;
  List<ImageUrl>? imageUrl;
  List<Activities>? activities;
  dynamic custEditNeeded;
  VisitItemsModel(
      {this.name,
      this.customerType,
      this.customerLevel,
      this.verificType,
      this.unvCustomer,
      this.unvCustomerName,
      this.customer,
      this.customerName,
      this.channelPartner,
      this.kycStatus,
      this.dealType,
      this.latitude,
      this.longitude,
      this.hasTrialPlan,
      this.shop,
      this.shopName,
      this.status,
      this.location,
      this.addressTitle,
      this.addressLine1,
      this.addressLine2,
      this.district,
      this.state,
      this.pincode,
      this.appointmentDate,
      this.conductBy,
      this.trialType,
      this.mapLocation,
      this.remarksnotes,
      this.visitStart,
      this.visitEnd,
      this.visitDuration,
      this.workflowState,
      this.productPitching,
      this.productTrial,
      this.itemTrial,
      this.contact,
      this.imageUrl,
      this.activities,
      this.custEditNeeded});

  VisitItemsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    customerType = json['customer_type'];
    customerLevel = json['customer_level'];
    verificType = json['verific_type'];
    unvCustomer = json['unv_customer'];
    unvCustomerName = json['unv_customer_name'];
    customer = json['customer'];
    customerName = json['customer_name'];
    channelPartner = json['channel_partner'];
    kycStatus = json['kyc_status'];
    dealType = json['deal_type'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    hasTrialPlan = json['has_trial_plan'];
    shop = json['shop'];
    shopName = json['shop_name'];
    status = json['status'];
    location = json['location'];
    addressTitle = json['address_title'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    district = json['district'];
    state = json['state'];
    pincode = json['pincode'];
    appointmentDate = json['appointment_date'];
    conductBy = json['conduct_by'];
    trialType = json['trial_type'];
    mapLocation = json['map_location'];
    remarksnotes = json['remarksnotes'];
    visitStart = json['visit_start'];
    visitEnd = json['visit_end'];
    visitDuration = json['visit_duration'];
    workflowState = json['workflow_state'];
    custEditNeeded = json['cust_edit_needed'];
    if (json['product_pitching'] != null) {
      productPitching = <ProductPitching>[];
      json['product_pitching'].forEach((v) {
        productPitching!.add( ProductPitching.fromJson(v));
      });
    }
     if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add( Activities.fromJson(v));
      });
    }
   
    // if (json['product_trial'] != null) {
    //   productTrial = <Null>[];
    //   json['product_trial'].forEach((v) {
    //     productTrial!.add( Null.fromJson(v));
    //   });
    // }
    // if (json['item_trial'] != null) {
    //   itemTrial = <Null>[];
    //   json['item_trial'].forEach((v) {
    //     itemTrial!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['contact'] != null) {
      contact = <Contact>[];
      json['contact'].forEach((v) {
        contact!.add(new Contact.fromJson(v));
      });
    }
    if (json['image_url'] != null) {
      imageUrl = <ImageUrl>[];
      json['image_url'].forEach((v) {
        imageUrl!.add(new ImageUrl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['customer_type'] = customerType;
    data['customer_level'] = customerLevel;
    data['verific_type'] = verificType;
    data['unv_customer'] = unvCustomer;
    data['unv_customer_name'] = unvCustomerName;
    data['customer'] = customer;
    data['customer_name'] = customerName;
    data['channel_partner'] = channelPartner;
    data['kyc_status'] = kycStatus;
    data['deal_type'] = dealType;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['has_trial_plan'] = hasTrialPlan;
    data['shop'] = shop;
    data['shop_name'] = shopName;
    data['status'] = status;
    data['location'] = location;
    data['address_title'] = addressTitle;
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    data['district'] = district;
    data['state'] = state;
    data['pincode'] = pincode;
    data['appointment_date'] = appointmentDate;
    data['conduct_by'] = conductBy;
    data['trial_type'] = trialType;
    data['map_location'] = mapLocation;
    data['remarksnotes'] = remarksnotes;
    data['visit_start'] = visitStart;
    data['visit_end'] = visitEnd;
    data['visit_duration'] = visitDuration;
    data['workflow_state'] = workflowState;
    data['cust_edit_needed'] = custEditNeeded;
    if (productPitching != null) {
      data['product_pitching'] =
          productPitching!.map((v) => v.toJson()).toList();
    }
    if (productTrial != null) {
      data['product_trial'] =
          productTrial!.map((v) => v.toJson()).toList();
    }
    if (itemTrial != null) {
      data['item_trial'] = itemTrial!.map((v) => v.toJson()).toList();
    }
    if (contact != null) {
      data['contact'] = contact!.map((v) => v.toJson()).toList();
    }
    if (imageUrl != null) {
      data['image_url'] = imageUrl!.map((v) => v.toJson()).toList();
    }
    if (activities != null) {
      data['activities'] = activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductPitching {
  dynamic product;
  List<Item>? item;

  ProductPitching(
      {
      this.product,
      this.item});

  ProductPitching.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    if (json['items'] != null) {
      item = <Item>[];
      json['items'].forEach((v) {
        item!.add( Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['product'] = product;
    if (item != null) {
      data['items'] = item!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
 dynamic name;
dynamic product;
  dynamic itemCode;
  dynamic itemName;
  dynamic itemCategory;
  dynamic qty;
  dynamic competitor;


  Item({
    this.name,this.product,
    this.itemCode, this.itemName, this.itemCategory,this.qty,this.competitor});

  Item.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemName = json['item_name'];
    itemCategory = json['item_category'];
    name = json['name'];
    competitor = json['competitor'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_code'] = itemCode;
    data['item_name'] = itemName;
    data['item_category'] = itemCategory;
    data['qty'] = qty;
    return data;
  }
}

class Contact {
  dynamic name;
  dynamic contact;

  Contact({this.name, this.contact});

  Contact.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['contact'] = contact;
    return data;
  }
}

class ImageUrl {
  dynamic fileUrl;

  ImageUrl({this.fileUrl});

  ImageUrl.fromJson(Map<String, dynamic> json) {
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_url'] = fileUrl;
    return data;
  }
}
