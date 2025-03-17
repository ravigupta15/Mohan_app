class SalesOrderModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  SalesOrderModel({this.status, this.message, this.data});

  SalesOrderModel.fromJson(Map<String, dynamic> json) {
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
  List<SalesRecords>? records;
  dynamic totalCount;
  dynamic pageCount;
  dynamic currentPage;

  Data({this.records, this.totalCount, this.pageCount, this.currentPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <SalesRecords>[];
      json['records'].forEach((v) {
        records!.add( SalesRecords.fromJson(v));
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

class SalesRecords {
  dynamic name;
  dynamic customShopName;
  dynamic contact;
  dynamic location;
  dynamic createdBy;
  dynamic workflowState;
  dynamic totalCount;
  dynamic formUrl;

  SalesRecords(
      {this.name,
      this.customShopName,
      this.contact,
      this.location,
      this.createdBy,
      this.workflowState,
      this.totalCount,
      this.formUrl});

  SalesRecords.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    customShopName = json['custom_shop_name'];
    contact = json['contact'];
    location = json['location'];
    createdBy = json['created_by'];
    workflowState = json['workflow_state'];
    totalCount = json['total_count'];
    formUrl = json['form_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['custom_shop_name'] = customShopName;
    data['contact'] = contact;
    data['location'] = location;
    data['created_by'] = createdBy;
    data['workflow_state'] = workflowState;
    data['total_count'] = totalCount;
    data['form_url'] = formUrl;
    return data;
  }
}
