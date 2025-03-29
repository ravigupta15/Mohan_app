class CollateralsRequestModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  CollateralsRequestModel({this.status, this.message, this.data});

  CollateralsRequestModel.fromJson(Map<String, dynamic> json) {
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
  List<CollateralsItems>? records;
  dynamic totalCount;
  dynamic pageCount;
  dynamic currentpage;

  Data({this.records, this.totalCount, this.currentpage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <CollateralsItems>[];
      json['records'].forEach((v) {
        records!.add( CollateralsItems.fromJson(v));
      });
    }
    totalCount = json['total_count'];
    pageCount = json['page_count'];
    currentpage = json['currentpage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    data['total_count'] = totalCount;
    data['page_count'] = pageCount;
    data['currentpage'] = currentpage;
    return data;
  }
}

class CollateralsItems {
  dynamic name;
  dynamic approvedDate;
  dynamic statusDate;
  dynamic status;
  dynamic totalCount;
  dynamic formUrl;

  CollateralsItems(
      {this.name,
      this.approvedDate,
      this.statusDate,
      this.status,
      this.totalCount,
      this.formUrl});

  CollateralsItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    approvedDate = json['approved_date'];
    statusDate = json['status_date'];
    status = json['status'];
    totalCount = json['total_count'];
    formUrl = json['form_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['approved_date'] = approvedDate;
    data['status_date'] = statusDate;
    data['status'] = status;
    data['total_count'] = totalCount;
    data['form_url'] = formUrl;
    return data;
  }
}
