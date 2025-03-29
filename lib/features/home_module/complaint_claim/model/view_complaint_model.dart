import 'package:mohan_impex/features/home_module/kyc/model/activity_model.dart';

class ViewComplaintModel {
  dynamic status;
  String? message;
  List<ComplaintData>? data;

  ViewComplaintModel({this.status, this.message, this.data});

  ViewComplaintModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ComplaintData>[];
      json['data'].forEach((v) {
        data!.add( ComplaintData.fromJson(v));
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

class ComplaintData {
  dynamic subject;
  dynamic claimType;
  dynamic customerLevel;
  dynamic customer;
  dynamic customerName;
  dynamic contact;
  dynamic date;
  dynamic shop;
  dynamic shopName;
  dynamic invoiceNo;
  dynamic invoiceDate;
  dynamic district;
  dynamic state;
  dynamic pincode;
  dynamic description;
  List<ComplaintItem>? complaintItem;
List<ImageUrl>? imageUrl;
List<Activities>? activities;
  ComplaintData(
      {
        this.subject,
        this.claimType,
        this.customerLevel,
        this.customer,
        this.customerName,
        this.contact,
        this.date,
        this.shop,
        this.shopName,
        this.invoiceDate,
        this.invoiceNo,
        this.district,
        this.state,
        this.pincode,
        this.description,
        this.complaintItem,
      this.imageUrl,
      this.activities
      });

  ComplaintData.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    claimType = json['claim_type'];
    customerLevel = json['customer_level'];
    customer = json['customer'];
    customerName = json['customer_name'];
    contact = json['contact'];
    date = json['date'];
    shop = json['shop'];
    shopName = json['shop_name'];
    invoiceNo = json['invoice_no'];
    invoiceDate = json['invoice_date'];
    district = json['district'];
    state = json['state'];
    pincode = json['pincode'];
    description = json['description'];
    if (json['complaint_item'] != null) {
      complaintItem = <ComplaintItem>[];
      json['complaint_item'].forEach((v) {
        complaintItem!.add(ComplaintItem.fromJson(v));
      });
    }
     if (json['image_url'] != null) {
      imageUrl = <ImageUrl>[];
      json['image_url'].forEach((v) {
        imageUrl!.add(new ImageUrl.fromJson(v));
      });
    }
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(new Activities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = subject;
    data['claim_type'] = claimType;
    data['customer_level'] = customerLevel;
    data['customer'] = customer;
    data['customer_name'] = customerName;
    data['contact'] = contact;
    data['date'] = date;
    data['shop'] = shop;
    data['shop_name'] = shopName;
    data['invoice_no'] = invoiceNo;
    data['invoice_date'] = invoiceDate;
    data['district'] = district;
    data['state'] = state;
    data['pincode'] = pincode;
    data['description'] = description;
    if (complaintItem != null) {
      data['complaint_item'] =
          complaintItem!.map((v) => v.toJson()).toList();
    }
    if (imageUrl != null) {
      data['image_url'] = imageUrl!.map((v) => v.toJson()).toList();
    }
   if (this.activities != null) {
      data['activities'] = this.activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class ComplaintItem {
  dynamic itemCode;
  dynamic itemName;
  dynamic complaintItmQty;
  dynamic valueOfGoods;
  dynamic batchNo;
  dynamic expiry;
  dynamic mfd;

  ComplaintItem(
      {this.itemCode,
      this.itemName,
      this.complaintItmQty,
      this.valueOfGoods,
      this.batchNo,
      this.expiry,
      this.mfd});

  ComplaintItem.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemName = json['item_name'];
    complaintItmQty = json['complaint_itm_qty'];
    valueOfGoods = json['value_of_goods'];
    batchNo = json['batch_no'];
    expiry = json['expiry'];
    mfd = json['mfd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['item_code'] = itemCode;
    data['item_name'] = itemName;
    data['complaint_itm_qty'] = complaintItmQty;
    data['value_of_goods'] = valueOfGoods;
    data['batch_no'] = batchNo;
    data['expiry'] = expiry;
    data['mfd'] = mfd;
    return data;
  }
}
class ImageUrl {
  dynamic fileName;
  dynamic fileUrl;

  ImageUrl({this.fileName, this.fileUrl});

  ImageUrl.fromJson(Map<String, dynamic> json) {
    fileName = json['file_name'];
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_name'] = fileName;
    data['file_url'] = fileUrl;
    return data;
  }
}