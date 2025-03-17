class SchemeModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  SchemeModel({this.status, this.message, this.data});

  SchemeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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
  List<SchemeRecord>? records;
  dynamic totalCount;
  dynamic pageCount;
  dynamic currentPage;

  Data({this.records, this.totalCount, this.pageCount, this.currentPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <SchemeRecord>[];
      json['records'].forEach((v) {
        records!.add( SchemeRecord.fromJson(v));
      });
    }
    totalCount = json['total_count'];
    pageCount = json['page_count'];
    currentPage = json['current_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    data['total_count'] = this.totalCount;
    data['page_count'] = this.pageCount;
    data['current_page'] = this.currentPage;
    return data;
  }
}

class SchemeRecord {
  dynamic title;
  dynamic schemeType;
  dynamic description;
  dynamic discountPercentage;
  dynamic termsAndConditions;
  dynamic validUpto;
  dynamic minQty;
  dynamic totalCount;

  SchemeRecord(
      {this.title,
      this.schemeType,
      this.description,
      this.discountPercentage,
      this.termsAndConditions,
      this.validUpto,
      this.minQty,
      this.totalCount});

  SchemeRecord.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    schemeType = json['scheme_type'];
    description = json['description'];
    discountPercentage = json['discount_percentage'];
    termsAndConditions = json['terms_and_conditions'];
    validUpto = json['valid_upto'];
    minQty = json['min_qty'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['scheme_type'] = this.schemeType;
    data['description'] = this.description;
    data['discount_percentage'] = this.discountPercentage;
    data['terms_and_conditions'] = this.termsAndConditions;
    data['valid_upto'] = this.validUpto;
    data['min_qty'] = this.minQty;
    data['total_count'] = this.totalCount;
    return data;
  }
}
