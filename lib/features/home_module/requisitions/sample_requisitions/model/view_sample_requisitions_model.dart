class ViewSampleRequisitionsModel {
  Message? message;

  ViewSampleRequisitionsModel({this.message});

  ViewSampleRequisitionsModel.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ?  Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

class Message {
  dynamic name;
  dynamic owner;
  dynamic creation;
  dynamic modified;
  dynamic modifiedBy;
  dynamic docstatus;
  dynamic idx;
  dynamic reqdDate;
  dynamic status;
  dynamic remarks;
  dynamic createdByEmp;
  dynamic area;
  dynamic workflowState;
  dynamic doctype;
  List<SampReqItem>? sampReqItem;

  Message(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.reqdDate,
      this.status,
      this.remarks,
      this.createdByEmp,
      this.area,
      this.workflowState,
      this.doctype,
      this.sampReqItem});

  Message.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    reqdDate = json['reqd_date'];
    status = json['status'];
    remarks = json['remarks'];
    createdByEmp = json['created_by_emp'];
    area = json['area'];
    workflowState = json['workflow_state'];
    doctype = json['doctype'];
    if (json['samp_req_item'] != null) {
      sampReqItem = <SampReqItem>[];
      json['samp_req_item'].forEach((v) {
        sampReqItem!.add( SampReqItem.fromJson(v));
      });
    }
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
    data['reqd_date'] = reqdDate;
    data['status'] = status;
    data['remarks'] = remarks;
    data['created_by_emp'] = createdByEmp;
    data['area'] = area;
    data['workflow_state'] = workflowState;
    data['doctype'] = doctype;
    if (sampReqItem != null) {
      data['samp_req_item'] = sampReqItem!.map((v) => v.toJson()).toList();
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
    data['name'] = name;
    data['owner'] = owner;
    data['creation'] = creation;
    data['modified'] = modified;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['item'] = item;
    data['qty'] = qty;
    data['parent'] = parent;
    data['parentfield'] = parentfield;
    data['parenttype'] = parenttype;
    data['doctype'] = doctype;
    return data;
  }
}
