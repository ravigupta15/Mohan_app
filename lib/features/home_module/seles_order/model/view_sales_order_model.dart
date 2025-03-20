import 'package:mohan_impex/features/home_module/kyc/model/activity_model.dart';

class ViewSalesOrderModel {
  dynamic status;
  dynamic message;
  List<ViewSalesItem>? data;

  ViewSalesOrderModel({this.status, this.message, this.data});

  ViewSalesOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewSalesItem>[];
      json['data'].forEach((v) {
        data!.add( ViewSalesItem.fromJson(v));
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

class ViewSalesItem {
  dynamic name;
  dynamic customerLevel;
  dynamic customer;
  dynamic customerName;
  dynamic shopName;
  dynamic channelPartner;
  dynamic dealType;
  dynamic location;
  dynamic contact;
  List<ItemsTemplate>? itemsTemplate;
  List<Activities>? activities;

  ViewSalesItem(
      {this.name,
      this.customerLevel,
      this.customer,
      this.customerName,
      this.shopName,
      this.channelPartner,
      this.dealType,
      this.location,
      this.contact,
      this.itemsTemplate,
      this.activities});

  ViewSalesItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    customerLevel = json['customer_level'];
    customer = json['customer'];
    customerName = json['customer_name'];
    shopName = json['shop_name'];
    channelPartner = json['channel_partner'];
    dealType = json['deal_type'];
    location = json['location'];
    contact = json['contact'];
    if (json['items'] != null) {
      itemsTemplate = <ItemsTemplate>[];
      json['items'].forEach((v) {
        itemsTemplate!.add( ItemsTemplate.fromJson(v));
      });
    }
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add( Activities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['customer_level'] = customerLevel;
    data['customer'] = customer;
    data['customer_name'] = customerName;
    data['shop_name'] = shopName;
    data['channel_partner'] = channelPartner;
    data['deal_type'] = dealType;
    data['location'] = location;
    data['contact'] = contact;
    if (itemsTemplate != null) {
      data['items'] = itemsTemplate!.map((v) => v.toJson()).toList();
    }
    if (activities != null) {
      data['activities'] = activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemsTemplate {
  String? itemTemplate;
  List<Items>? items;

  ItemsTemplate({this.itemTemplate, this.items});

  ItemsTemplate.fromJson(Map<String, dynamic> json) {
    itemTemplate = json['item_template'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_template'] = itemTemplate;
    if (this.items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Items {
  dynamic itemTemplate;
  dynamic itemCode;
  dynamic itemName;
  dynamic itemCategory;
  dynamic competitor;
  dynamic qty;
  dynamic uom;

  Items(
      {this.itemTemplate,
      this.itemCode,
      this.itemName,
      this.itemCategory,
      this.competitor,
      this.qty,
      this.uom});

  Items.fromJson(Map<String, dynamic> json) {
    itemTemplate = json['item_template'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    itemCategory = json['item_category'];
    competitor = json['competitor'];
    qty = json['qty'];
    uom = json['uom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['item_template'] = itemTemplate;
    data['item_code'] = itemCode;
    data['item_name'] = itemName;
    data['item_category'] = itemCategory;
    data['competitor'] = competitor;
    data['qty'] = qty;
    data['uom'] = uom;
    return data;
  }
}
