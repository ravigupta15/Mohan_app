class MyCustomerModel {
  dynamic status;
  String? message;
  List<Data>? data;

  MyCustomerModel({this.status, this.message, this.data});

  MyCustomerModel.fromJson(Map<String, dynamic> json) {
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
  List<MyCustomerRecords>? records;
  dynamic totalCount;
  dynamic pageCount;
  dynamic currentPage;

  Data({this.records, this.totalCount, this.pageCount, this.currentPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <MyCustomerRecords>[];
      json['records'].forEach((v) {
        records!.add( MyCustomerRecords.fromJson(v));
      });
    }
    totalCount = json['total_count'] ?? 0;
    pageCount = json['page_count'] ?? 0;
    currentPage = json['current_page'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    data['total_count'] = totalCount;
    data['page_count'] = pageCount;
    data['current_page'] = currentPage;
    return data;
  }
}

class MyCustomerRecords {
  dynamic name;
  dynamic customerName;
  dynamic customShop;
  dynamic contact;
  dynamic location;
  dynamic createdBy;
  dynamic workflowState;
  dynamic totalCount;
  dynamic formUrl;

  MyCustomerRecords(
      {this.name,
      this.customerName,
      this.customShop,
      this.contact,
      this.location,
      this.createdBy,
      this.workflowState,
      this.totalCount,
      this.formUrl});

  MyCustomerRecords.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    customerName = json['customer_name'];
    customShop = json['custom_shop'];
    contact = json['contact'];
    location = json['location'];
    createdBy = json['created_by'];
    workflowState = json['workflow_state'];
    totalCount = json['total_count'];
    formUrl = json['form_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['customer_name'] = this.customerName;
    data['custom_shop'] = this.customShop;
    data['contact'] = this.contact;
    data['location'] = this.location;
    data['created_by'] = this.createdBy;
    data['workflow_state'] = this.workflowState;
    data['total_count'] = this.totalCount;
    data['form_url'] = this.formUrl;
    return data;
  }
}
