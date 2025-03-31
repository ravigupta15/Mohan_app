class KycModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  KycModel({this.status, this.message, this.data});

  KycModel.fromJson(Map<String, dynamic> json) {
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
  List<KycRecords>? records;
  dynamic totalCount;
  dynamic pageCount;
  dynamic currentPage;

  Data({this.records, this.totalCount, this.pageCount, this.currentPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <KycRecords>[];
      json['records'].forEach((v) {
        records!.add( KycRecords.fromJson(v));
      });
    }
    totalCount = json['total_count'] ?? 0;
    pageCount = json['page_count'] ?? 0;
    currentPage = json['current_page'] ?? 0;
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

class KycRecords {
  dynamic name;
  dynamic createdDate;
  dynamic workflowState;
  dynamic totalCount;
  dynamic customerName;
  dynamic formUrl;
  dynamic statusDate;

  KycRecords(
      {this.name,
      this.createdDate,
      this.workflowState,
      this.totalCount,
      this.customerName,
      this.formUrl,
      this.statusDate});

  KycRecords.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    createdDate = json['created_date'];
    workflowState = json['workflow_state'];
    totalCount = json['total_count'];
    customerName = json['customer_name'];
    formUrl = json['form_url'];
    statusDate = json['status_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['created_date'] = createdDate;
    data['workflow_state'] = workflowState;
    data['total_count'] = totalCount;
    data['customer_name'] = customerName;
    data['form_url'] = formUrl;
    data['status_date'] = statusDate;
    return data;
  }
}
