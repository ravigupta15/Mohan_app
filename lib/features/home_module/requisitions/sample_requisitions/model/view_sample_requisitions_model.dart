import '../../../kyc/model/activity_model.dart';

class ViewSampleRequisitionsModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  ViewSampleRequisitionsModel({this.status, this.message, this.data});

  ViewSampleRequisitionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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
  dynamic owner;
  dynamic creation;
  dynamic modified;
  dynamic modifiedBy;
  dynamic docstatus;
  dynamic idx;
dynamic reqdDate;
  dynamic approvedDate;
  dynamic status;
  dynamic amendedFrom;
  dynamic remarks;
  dynamic createdByEmp;
  dynamic area;
  dynamic workflowState;
  dynamic doctype;
  List<SampReqItem>? sampReqItem;
  List<Activities>? activities;

  Data(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.reqdDate,
      this.approvedDate,
      this.status,
      this.amendedFrom,
      this.remarks,
      this.createdByEmp,
      this.area,
      this.workflowState,
      this.doctype,
      this.sampReqItem,
      this.activities});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    reqdDate = json['reqd_date'];
    approvedDate = json['approved_date'];
    status = json['status'];
    amendedFrom = json['amended_from'];
    remarks = json['remarks'];
    createdByEmp = json['created_by_emp'];
    area = json['area'];
    workflowState = json['workflow_state'];
    doctype = json['doctype'];
    if (json['samp_req_item'] != null) {
      sampReqItem = <SampReqItem>[];
      json['samp_req_item'].forEach((v) {
        sampReqItem!.add(new SampReqItem.fromJson(v));
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
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['reqd_date'] = this.reqdDate;
    data['approved_date'] = this.approvedDate;
    data['status'] = this.status;
    data['amended_from'] = this.amendedFrom;
    data['remarks'] = this.remarks;
    data['created_by_emp'] = this.createdByEmp;
    data['area'] = this.area;
    data['workflow_state'] = this.workflowState;
    data['doctype'] = this.doctype;
    if (this.sampReqItem != null) {
      data['samp_req_item'] = this.sampReqItem!.map((v) => v.toJson()).toList();
    }
    if (this.activities != null) {
      data['activities'] = this.activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SampReqItem {
  dynamic name;
  dynamic owner;
  dynamic creation;
  dynamic modified;
  dynamic modifiedBy;
  dynamic docstatus;
  dynamic idx;
  dynamic item;
  dynamic qty;
  dynamic parent;
  dynamic parentfield;
  dynamic parenttype;
  dynamic doctype;

  SampReqItem(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.item,
      this.qty,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.doctype});

  SampReqItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    item = json['item'];
    qty = json['qty'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['item'] = this.item;
    data['qty'] = this.qty;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['doctype'] = this.doctype;
    return data;
  }
}
