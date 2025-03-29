class ComplaintModel {
  dynamic status;
  dynamic message;
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
  List<ComplaintRecords>? records;
  dynamic totalCount;
  dynamic pageCount;
  dynamic currentPage;

  Data({this.records, this.totalCount, this.pageCount, this.currentPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <ComplaintRecords>[];
      json['records'].forEach((v) {
        records!.add( ComplaintRecords.fromJson(v));
      });
    }
    totalCount = json['total_count'];
    pageCount = json['page_count'];
    currentPage = json['current_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    data['total_count'] = totalCount;
    data['page_count'] = pageCount;
    data['current_page'] = currentPage;
    return data;
  }
}

class ComplaintRecords {
  dynamic name;
  dynamic date;
  dynamic claimType;
  dynamic workflowState;
  dynamic totalCount;
  dynamic customerName;
  dynamic statusDate;
  dynamic formUrl;

  ComplaintRecords(
      {this.name,
      this.date,
      this.claimType,
      this.workflowState,
      this.totalCount,
      this.customerName,
      this.statusDate,
      this.formUrl});

  ComplaintRecords.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    claimType = json['claim_type'];
    workflowState = json['workflow_state'];
    totalCount = json['total_count'];
    customerName = json['customer_name'];
    statusDate = json['status_date'];
    formUrl = json['form_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['date'] = date;
    data['claim_type'] = claimType;
    data['workflow_state'] = workflowState;
    data['total_count'] = totalCount;
    data['customer_name'] = customerName;
    data['status_date'] = statusDate;
    data['form_url'] = formUrl;
    return data;
  }
}
