class TrialPlanModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  TrialPlanModel({this.status, this.message, this.data});

  TrialPlanModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  List<Pending>? approved;
  List<Pending>? pending;
  bool? createPerm;

  Data({this.approved, this.pending, this.createPerm});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['approved'] != null) {
      approved = <Pending>[];
      json['approved'].forEach((v) {
        approved!.add(new Pending.fromJson(v));
      });
    }
    if (json['pending'] != null) {
      pending = <Pending>[];
      json['pending'].forEach((v) {
        pending!.add(new Pending.fromJson(v));
      });
    }
    createPerm = json['create_perm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (approved != null) {
      data['approved'] = approved!.map((v) => v.toJson()).toList();
    }
    if (pending != null) {
      data['pending'] = pending!.map((v) => v.toJson()).toList();
    }
    data['create_perm'] = createPerm;
    return data;
  }
}

class Pending {
  dynamic name;
  dynamic trialType;
  dynamic shopName;
  dynamic location;
  dynamic createdByEmp;
  dynamic workflowState;
  List<String>? contact;
  dynamic formUrl;

  Pending(
      {this.name,
      this.trialType,
      this.shopName,
      this.location,
      this.createdByEmp,
      this.workflowState,
      this.contact,
      this.formUrl});

  Pending.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    trialType = json['trial_type'];
    shopName = json['shop_name'];
    location = json['location'];
    createdByEmp = json['created_by_emp'];
    workflowState = json['workflow_state'];
    contact = json['contact'].cast<String>();
    formUrl = json['form_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['trial_type'] = trialType;
    data['shop_name'] = shopName;
    data['location'] = location;
    data['created_by_emp'] = createdByEmp;
    data['workflow_state'] = workflowState;
    data['contact'] = contact;
    data['form_url'] = formUrl;
    return data;
  }
}
