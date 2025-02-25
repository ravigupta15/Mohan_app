class CustomerVisitModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  CustomerVisitModel({this.status, this.message, this.data});

  CustomerVisitModel.fromJson(Map<String, dynamic> json) {
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
  List<MyVisit>? myVisit;
  List<MyVisit>? visitDraft;
  Perms? perms;

  Data({this.myVisit, this.visitDraft, this.perms});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['my_visit'] != null) {
      myVisit = <MyVisit>[];
      json['my_visit'].forEach((v) {
        myVisit!.add( MyVisit.fromJson(v));
      });
    }
     if (json['visit_draft'] != null) {
      myVisit = <MyVisit>[];
      json['visit_draft'].forEach((v) {
        myVisit!.add( MyVisit.fromJson(v));
      });
    }
    perms = json['perms'] != null ?  Perms.fromJson(json['perms']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (myVisit != null) {
      data['my_visit'] = myVisit!.map((v) => v.toJson()).toList();
    }
    if (visitDraft != null) {
      data['visit_draft'] = visitDraft!.map((v) => v.toJson()).toList();
    }
    if (perms != null) {
      data['perms'] = perms!.toJson();
    }
    return data;
  }
}

class MyVisit {
  dynamic name;
  dynamic shopName;
  dynamic contact;
  dynamic location;
  dynamic createdByEmp;
  dynamic kycStatus;
  dynamic workflowState;
  dynamic formUrl;

  MyVisit(
      {this.name,
      this.shopName,
      this.contact,
      this.location,
      this.createdByEmp,
      this.kycStatus,
      this.workflowState,
      this.formUrl});

  MyVisit.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shopName = json['shop_name'];
    contact = json['contact'];
    location = json['location'];
    createdByEmp = json['created_by_emp'];
    kycStatus = json['kyc_status'];
    workflowState = json['workflow_state'];
    formUrl = json['form_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['shop_name'] = shopName;
    data['contact'] = contact;
    data['location'] = location;
    data['created_by_emp'] = createdByEmp;
    data['kyc_status'] = kycStatus;
    data['workflow_state'] = workflowState;
    data['form_url'] = formUrl;
    return data;
  }
}

class Perms {
  dynamic createPerm;

  Perms({this.createPerm});

  Perms.fromJson(Map<String, dynamic> json) {
    createPerm = json['create_perm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['create_perm'] = createPerm;
    return data;
  }
}
