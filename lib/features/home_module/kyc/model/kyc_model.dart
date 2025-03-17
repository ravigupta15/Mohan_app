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
  dynamic date;
  dynamic workflowState;
  dynamic totalCount;
  dynamic username;
  dynamic formUrl;

  KycRecords(
      {this.name,
      this.date,
      this.workflowState,
      this.totalCount,
      this.username,
      this.formUrl});

  KycRecords.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    workflowState = json['workflow_state'];
    totalCount = json['total_count'];
    username = json['username'];
    formUrl = json['form_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['date'] = date;
    data['workflow_state'] = workflowState;
    data['total_count'] = totalCount;
    data['username'] = username;
    data['form_url'] = formUrl;
    return data;
  }
}
