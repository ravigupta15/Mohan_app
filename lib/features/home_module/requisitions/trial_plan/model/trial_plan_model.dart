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
  List<TrialRecords>? records;
  dynamic totalCount;
  dynamic pageCount;
  dynamic currentPage;

  Data({this.records, this.totalCount, this.pageCount, this.currentPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <TrialRecords>[];
      json['records'].forEach((v) {
        records!.add( TrialRecords.fromJson(v));
      });
    }
    totalCount = json['total_count'];
    pageCount = json['page_count'];
    currentPage = json['current_page'] ?? 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    data['total_count'] = totalCount;
    data['page_count'] = pageCount;
    data['current_page'] = currentPage;
    return data;
  }
}

class TrialRecords {
  dynamic name;
  dynamic trialType;
  dynamic shopName;
  dynamic contact;
  dynamic location;
  dynamic createdByEmp;
  dynamic workflowState;
  dynamic date;
  dynamic totalCount;

  TrialRecords(
      {this.name,
      this.trialType,
      this.shopName,
      this.contact,
      this.location,
      this.createdByEmp,
      this.workflowState,
      this.date,
      this.totalCount});

  TrialRecords.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    trialType = json['trial_type'];
    shopName = json['shop_name'];
    contact = json['contact'];
    location = json['location'];
    createdByEmp = json['created_by_emp'];
    workflowState = json['workflow_state'];
    date = json['date'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['trial_type'] = trialType;
    data['shop_name'] = shopName;
    data['contact'] = contact;
    data['location'] = location;
    data['created_by_emp'] = createdByEmp;
    data['workflow_state'] = workflowState;
    data['date'] = date;
    data['total_count'] = totalCount;
    return data;
  }
}
