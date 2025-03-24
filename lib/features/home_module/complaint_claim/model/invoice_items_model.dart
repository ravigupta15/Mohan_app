import 'package:flutter/material.dart';

class InvoiceItemsModel {
  dynamic status;
  dynamic message;
  List<InvoiceItemRecords>? data;

  InvoiceItemsModel({this.status, this.message, this.data});

  InvoiceItemsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <InvoiceItemRecords>[];
      json['data'].forEach((v) {
        data!.add( InvoiceItemRecords.fromJson(v));
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

class InvoiceItemRecords {
  dynamic itemCode;
  dynamic itemName;
  dynamic qty;
  dynamic amount;
  String? selectedItemCode;
  String? selectedItemName;
  DateTime? expiryDate;
  DateTime? mfdDate;
  String? selectedDropdownValue;
  TextEditingController valueOfGoodsController = TextEditingController();
  TextEditingController itemQuantityController = TextEditingController();
  TextEditingController batchNoController = TextEditingController();
  TextEditingController mfdDateController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();

  InvoiceItemRecords({this.itemCode, this.itemName, this.qty, this.amount});

  InvoiceItemRecords.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemName = json['item_name'];
    qty = json['qty'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['item_code'] = itemCode;
    data['item_name'] = itemName;
    data['qty'] = qty;
    data['amount'] = amount;
    return data;
  }
}
