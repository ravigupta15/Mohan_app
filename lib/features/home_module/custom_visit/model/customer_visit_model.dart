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
  List<CustomerVisitRecords>? records;
  dynamic totalCount;
  dynamic pageCount;
  dynamic currentPage;

  Data({this.records, this.totalCount, this.pageCount, this.currentPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <CustomerVisitRecords>[];
      json['records'].forEach((v) {
        records!.add( CustomerVisitRecords.fromJson(v));
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

class CustomerVisitRecords {
  dynamic name;
  dynamic shopName;
  dynamic contact;
  dynamic location;
  dynamic createdByEmp;
  dynamic kycStatus;
  dynamic workflowState;
  dynamic totalCount;
  dynamic formUrl;
  dynamic imageUrl;

  CustomerVisitRecords(
      {this.name,
      this.shopName,
      this.contact,
      this.location,
      this.createdByEmp,
      this.kycStatus,
      this.workflowState,
      this.totalCount,
      this.formUrl,
      this.imageUrl});

  CustomerVisitRecords.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shopName = json['shop_name'];
    contact = json['contact'];
    location = json['location'];
    createdByEmp = json['created_by_emp'];
    kycStatus = json['kyc_status'];
    workflowState = json['workflow_state'];
    totalCount = json['total_count'];
    formUrl = json['form_url'];
    imageUrl = json['image_url'];
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
    data['total_count'] = totalCount;
    data['form_url'] = formUrl;
    data['image_url'] = imageUrl;
    return data;
  }
}
