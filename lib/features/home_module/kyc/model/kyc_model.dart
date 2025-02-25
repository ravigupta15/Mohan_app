class KYCModel {
  bool? status;
  String? message;
  List<Data>? data;

  KYCModel({this.status, this.message, this.data});

  KYCModel.fromJson(Map<String, dynamic> json) {
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
  List<Pending>? pending;
  List<Pending>? approved;
  Perms? perms;

  Data({this.pending, this.approved, this.perms});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['pending'] != null) {
      pending = <Pending>[];
      json['pending'].forEach((v) {
        pending!.add(new Pending.fromJson(v));
      });
    }
    if (json['approved'] != null) {
      approved = <Pending>[];
       json['approved'].forEach((v) {
        pending!.add( Pending.fromJson(v));
      });
     
    }
    perms = json['perms'] != null ?  Perms.fromJson(json['perms']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (pending != null) {
      data['pending'] = pending!.map((v) => v.toJson()).toList();
    }
    if (approved != null) {
      data['approved'] = approved!.map((v) => v.toJson()).toList();
    }
    if (perms != null) {
      data['perms'] = perms!.toJson();
    }
    return data;
  }
}

class Pending {
  dynamic name;
  dynamic date;
  dynamic workflowState;
  dynamic username;
  dynamic formUrl;

  Pending(
      {this.name, this.date, this.workflowState, this.username, this.formUrl});

  Pending.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    workflowState = json['workflow_state'];
    username = json['username'];
    formUrl = json['form_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['date'] = date;
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
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['create_perm'] = createPerm;
    return data;
  }
}
