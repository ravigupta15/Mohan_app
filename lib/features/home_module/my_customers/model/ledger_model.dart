class LedgerModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  LedgerModel({this.status, this.message, this.data});

  LedgerModel.fromJson(Map<String, dynamic> json) {
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
  List<LedgerRecords>? records;
  dynamic totalCount;
  dynamic pageCount;
  dynamic currentPage;

  Data({this.records, this.totalCount, this.pageCount, this.currentPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <LedgerRecords>[];
      json['records'].forEach((v) {
        records!.add( LedgerRecords.fromJson(v));
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

class LedgerRecords {
  dynamic name;
  dynamic date;
  dynamic amount;
  dynamic balance;
  dynamic creation;
  dynamic totalCount;

  LedgerRecords(
      {this.name,
      this.date,
      this.amount,
      this.balance,
      this.creation,
      this.totalCount});

  LedgerRecords.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    amount = json['amount'];
    balance = json['balance'];
    creation = json['creation'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['date'] = date;
    data['amount'] = amount;
    data['balance'] = balance;
    data['creation'] = creation;
    data['total_count'] = totalCount;
    return data;
  }
}
