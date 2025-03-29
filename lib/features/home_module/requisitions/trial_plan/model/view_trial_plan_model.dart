import 'package:mohan_impex/features/home_module/kyc/model/activity_model.dart';

class ViewTrialPlanModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  ViewTrialPlanModel({this.status, this.message, this.data});

  ViewTrialPlanModel.fromJson(Map<String, dynamic> json) {
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
  dynamic conductBy;
  dynamic trialType;
  dynamic trialLoc;
  dynamic customerLevel;
  dynamic verificType;
  dynamic customer;
  dynamic customerName;
  dynamic unvCustomer;
  dynamic unvCustomerName;
  dynamic channelPartner;
  dynamic shopName;
  dynamic appointmentDate;
 dynamic cvm;
  dynamic date;
  dynamic time;
  dynamic status;
  dynamic location;
  dynamic addressTitle;
  dynamic addressLine1;
  dynamic addressLine2;
  dynamic district;
  dynamic state;
  dynamic pincode;
  dynamic remarksnotes;
  dynamic visitStart;
  dynamic visitEnd;
  dynamic visitDuration;
  dynamic workflowState;
  dynamic assignedTo;
  List<ItemTrialTable>? itemTrialTable;
  List<Contact>? contact;
  List<ProductTrialTable>? productTrialTable;
  List<Activities>? activities;
  TsmInfo? tsmInfo;

  Data(
      {this.name,
      this.conductBy,
      this.trialType,
      this.trialLoc,
      this.customerLevel,
      this.verificType,
      this.customer,
      this.customerName,
      this.unvCustomer,
      this.unvCustomerName,
      this.channelPartner,
      this.shopName,
      this.appointmentDate,
      this.cvm,
      this.date,
      this.time,
      this.status,
      this.location,
      this.addressTitle,
      this.addressLine1,
      this.addressLine2,
      this.district,
      this.state,
      this.pincode,
      this.remarksnotes,
      this.visitStart,
      this.visitEnd,
      this.visitDuration,
      this.workflowState,
      this.assignedTo,
      this.itemTrialTable,
      this.contact,
      this.productTrialTable,
      this.activities,
      this.tsmInfo});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    conductBy = json['conduct_by'];
    trialType = json['trial_type'];
    trialLoc = json['trial_loc'];
    customerLevel = json['customer_level'];
    verificType = json['verific_type'];
    customer = json['customer'];
    customerName = json['customer_name'];
    unvCustomer = json['unv_customer'];
    unvCustomerName = json['unv_customer_name'];
    channelPartner = json['channel_partner'];
    shopName = json['shop_name'];
    appointmentDate = json['appointment_date'];
    cvm = json['cvm'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    location = json['location'];
    addressTitle = json['address_title'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    district = json['district'];
    state = json['state'];
    pincode = json['pincode'];
    remarksnotes = json['remarksnotes'];
    visitStart = json['visit_start'];
    visitEnd = json['visit_end'];
    visitDuration = json['visit_duration'];
    workflowState = json['workflow_state'];
    assignedTo = json['assigned_to'];
    if (json['item_trial_table'] != null) {
      itemTrialTable = <ItemTrialTable>[];
      json['item_trial_table'].forEach((v) {
        itemTrialTable!.add( ItemTrialTable.fromJson(v));
      });
    }
    if (json['contact'] != null) {
      contact = <Contact>[];
      json['contact'].forEach((v) {
        contact!.add( Contact.fromJson(v));
      });
    }
    if (json['product_trial_table'] != null) {
      productTrialTable = <ProductTrialTable>[];
      json['product_trial_table'].forEach((v) {
        productTrialTable!.add( ProductTrialTable.fromJson(v));
      });
    }
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add( Activities.fromJson(v));
      });
    }
     tsmInfo = json['tsm_info'] != null
        ?  TsmInfo.fromJson(json['tsm_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['conduct_by'] = conductBy;
    data['trial_type'] = trialType;
    data['trial_loc'] = trialLoc;
    data['customer_level'] = customerLevel;
    data['verific_type'] = verificType;
    data['customer'] = customer;
    data['customer_name'] = customerName;
    data['unv_customer'] = unvCustomer;
    data['unv_customer_name'] = unvCustomerName;
    data['channel_partner'] = channelPartner;
    data['shop_name'] = shopName;
    data['appointment_date'] = appointmentDate;
    data['cvm'] = cvm;
    data['date'] = date;
    data['time'] = time;
    data['status'] = status;
    data['location'] = location;
    data['address_title'] = addressTitle;
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    data['district'] = district;
    data['state'] = state;
    data['pincode'] = pincode;
    data['remarksnotes'] = remarksnotes;
    data['visit_start'] = visitStart;
    data['visit_end'] = visitEnd;
    data['visit_duration'] = visitDuration;
    data['workflow_state'] = workflowState;
    data['assigned_to'] = assignedTo;
    if (itemTrialTable != null) {
      data['item_trial_table'] =
          itemTrialTable!.map((v) => v.toJson()).toList();
    }
    if (contact != null) {
      data['contact'] = contact!.map((v) => v.toJson()).toList();
    }
    if (productTrialTable != null) {
      data['product_trial_table'] =
          productTrialTable!.map((v) => v.toJson()).toList();
    }
    if (activities != null) {
      data['activities'] = activities!.map((v) => v.toJson()).toList();
    }
    if (tsmInfo != null) {
      data['tsm_info'] = tsmInfo!.toJson();
    }
    return data;
  }
}

class Contact {
  dynamic name;
  dynamic owner;
  dynamic creation;
  dynamic modified;
  dynamic modifiedBy;
  dynamic docstatus;
  dynamic idx;
  dynamic contact;
  dynamic parent;
  dynamic parentfield;
  dynamic parenttype;
  dynamic doctype;

  Contact(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.contact,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.doctype});

  Contact.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    contact = json['contact'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['owner'] = owner;
    data['creation'] = creation;
    data['modified'] = modified;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['contact'] = contact;
    data['parent'] = parent;
    data['parentfield'] = parentfield;
    data['parenttype'] = parenttype;
    data['doctype'] = doctype;
    return data;
  }
}

class ProductTrialTable {
  dynamic name;
  dynamic product;
 dynamic trialTemplate;
 dynamic remarks;

  ProductTrialTable(
      {this.name, this.product, this.trialTemplate, this.remarks});

  ProductTrialTable.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    product = json['product'];
    trialTemplate = json['trial_template'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['product'] = product;
    data['trial_template'] = trialTemplate;
    data['remarks'] = remarks;
    return data;
  }
}

class ItemTrialTable {
  dynamic name;
  dynamic owner;
  dynamic creation;
  dynamic modified;
  dynamic modifiedBy;
  dynamic docstatus;
  dynamic idx;
  dynamic itemCode;
  dynamic itemName;
  dynamic remarks;
  dynamic parent;
  dynamic parentfield;
  dynamic parenttype;
  dynamic doctype;

  ItemTrialTable(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.itemCode,
      this.itemName,
      this.remarks,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.doctype});

  ItemTrialTable.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    remarks = json['remarks'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['owner'] = owner;
    data['creation'] = creation;
    data['modified'] = modified;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['item_code'] = itemCode;
    data['item_name'] = itemName;
    data['remarks'] = remarks;
    data['parent'] = parent;
    data['parentfield'] = parentfield;
    data['parenttype'] = parenttype;
    data['doctype'] = doctype;
    return data;
  }
}

class TsmInfo {
  dynamic name;
  dynamic mobile;
  dynamic email;

  TsmInfo({this.name, this.mobile, this.email});

  TsmInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    return data;
  }
}