class ComplaintModel {
  dynamic status;
  String? message;
  List<Data>? data;

  ComplaintModel({this.status, this.message, this.data});

  ComplaintModel.fromJson(Map<String, dynamic> json) {
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
  List<Active>? active;
  List<Active>? resolved;
  Perms? perms;

  Data({this.active, this.resolved, this.perms});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['active'] != null) {
      active = <Active>[];
      json['active'].forEach((v) {
        active!.add( Active.fromJson(v));
      });
    }
    if (json['resolved'] != null) {
      resolved = <Active>[];
      json['resolved'].forEach((v) {
        resolved!.add( Active.fromJson(v));
      });
    }
    perms = json['perms'] != null ?  Perms.fromJson(json['perms']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (active != null) {
      data['active'] = active!.map((v) => v.toJson()).toList();
    }
    if (resolved != null) {
      data['resolved'] = resolved!.map((v) => v.toJson()).toList();
    }
    if (perms != null) {
      data['perms'] = perms!.toJson();
    }
    return data;
  }
}

class Active {
  dynamic name;
  dynamic date;
  dynamic claimType;
  dynamic workflowState;
  dynamic username;
  dynamic formUrl;

  Active(
      {this.name,
      this.date,
      this.claimType,
      this.workflowState,
      this.username,
      this.formUrl});

  Active.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    claimType = json['claim_type'];
    workflowState = json['workflow_state'];
    username = json['username'];
    formUrl = json['form_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['date'] = date;
    data['claim_type'] = claimType;
    data['workflow_state'] = workflowState;
    data['username'] = username;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_perm'] = this.createPerm;
    return data;
  }
}
