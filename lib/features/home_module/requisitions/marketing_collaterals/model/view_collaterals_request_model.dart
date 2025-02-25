class ViewCollateralsReqestModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  ViewCollateralsReqestModel({this.status, this.message, this.data});

  ViewCollateralsReqestModel.fromJson(Map<String, dynamic> json) {
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
  dynamic owner;
  dynamic creation;
  dynamic modified;
  dynamic modifiedBy;
  dynamic docstatus;
  dynamic idx;
  dynamic approvedDate;
  dynamic remarks;
  dynamic amendedFrom;
  dynamic createdByEmp;
  dynamic area;
  dynamic status;
  dynamic workflowState;
  dynamic doctype;
  List<MktgCollItem>? mktgCollItem;
  List<MarkingActivities>? activities;

  Data(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.approvedDate,
      this.remarks,
      this.amendedFrom,
      this.createdByEmp,
      this.area,
      this.status,
      this.workflowState,
      this.doctype,
      this.mktgCollItem,
      this.activities});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    approvedDate = json['approved_date'];
    remarks = json['remarks'];
    amendedFrom = json['amended_from'];
    createdByEmp = json['created_by_emp'];
    area = json['area'];
    status = json['status'];
    workflowState = json['workflow_state'];
    doctype = json['doctype'];
    if (json['mktg_coll_item'] != null) {
      mktgCollItem = <MktgCollItem>[];
      json['mktg_coll_item'].forEach((v) {
        mktgCollItem!.add(new MktgCollItem.fromJson(v));
      });
    }
    if (json['activities'] != null) {
      activities = <MarkingActivities>[];
      json['activities'].forEach((v) {
        activities!.add(new MarkingActivities.fromJson(v));
      });
    }
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
    data['approved_date'] = approvedDate;
    data['remarks'] = remarks;
    data['amended_from'] = amendedFrom;
    data['created_by_emp'] = createdByEmp;
    data['area'] = area;
    data['status'] = status;
    data['workflow_state'] = workflowState;
    data['doctype'] = doctype;
    if (mktgCollItem != null) {
      data['mktg_coll_item'] =
          mktgCollItem!.map((v) => v.toJson()).toList();
    }
    if (activities != null) {
      data['activities'] = activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MktgCollItem {
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

  MktgCollItem(
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

  MktgCollItem.fromJson(Map<String, dynamic> json) {
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

class MarkingActivities {
  dynamic role;
  dynamic name;
  dynamic status;
  dynamic comments;
  dynamic date;
  dynamic time;

  MarkingActivities(
      {this.role, this.name, this.status, this.comments, this.date, this.time});

  MarkingActivities.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    name = json['name'];
    status = json['status'];
    comments = json['comments'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = role;
    data['name'] = name;
    data['status'] = status;
    data['comments'] = comments;
    data['date'] =date;
    data['time'] =time;
    return data;
  }
}
