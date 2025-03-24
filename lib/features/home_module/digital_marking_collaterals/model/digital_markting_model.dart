class DigitalMarkingModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  DigitalMarkingModel({this.status, this.message, this.data});

  DigitalMarkingModel.fromJson(Map<String, dynamic> json) {
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
  List<DigitalRecords>? records;
  dynamic totalCount;
  dynamic pageCount;
  dynamic currentPage;

  Data({this.records, this.totalCount, this.pageCount, this.currentPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <DigitalRecords>[];
      json['records'].forEach((v) {
        records!.add(new DigitalRecords.fromJson(v));
      });
    }
    totalCount = json['total_count'];
    pageCount = json['page_count'];
    currentPage = json['current_page'];
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

class DigitalRecords {
  dynamic name;
  dynamic productName;
  dynamic productAttachment;
  dynamic thumbnailImage;
  dynamic totalCount;
  dynamic fileType;

  DigitalRecords(
      {this.name,
      this.productName,
      this.productAttachment,
      this.thumbnailImage,
      this.totalCount,
      this.fileType});

  DigitalRecords.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    productName = json['product_name'];
    productAttachment = json['product_attachment'];
    thumbnailImage = json['thumbnail_image'];
    totalCount = json['total_count'];
    fileType = json['file_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['product_name'] = productName;
    data['product_attachment'] = productAttachment;
    data['thumbnail_image'] = thumbnailImage;
    data['total_count'] = totalCount;
    data['file_type'] = fileType;
    return data;
  }
}
