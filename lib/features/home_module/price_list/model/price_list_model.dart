class PriceListModel {
  dynamic status;
  dynamic message;
  List<PriceListItem>? data;

  PriceListModel({this.status, this.message, this.data});

  PriceListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PriceListItem>[];
      json['data'].forEach((v) {
        data!.add( PriceListItem.fromJson(v));
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

class PriceListItem {
  List<Records>? records;
  dynamic totalCount;
  dynamic pageCount;
  dynamic currentPage;

  PriceListItem({this.records, this.totalCount, this.pageCount, this.currentPage});

  PriceListItem.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add( Records.fromJson(v));
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
    data['page_count'] =pageCount;
    data['current_page'] = currentPage;
    return data;
  }
}

class Records {
  dynamic itemCode;
  dynamic itemName;
  dynamic itemCategory;
  dynamic priceListRate;
  dynamic totalCount;

  Records(
      {this.itemCode,
      this.itemName,
      this.itemCategory,
      this.priceListRate,
      this.totalCount});

  Records.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemName = json['item_name'];
    itemCategory = json['item_category'];
    priceListRate = json['price_list_rate'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_code'] = itemCode;
    data['item_name'] = itemName;
    data['item_category'] = itemCategory;
    data['price_list_rate'] = priceListRate;
    data['total_count'] = totalCount;
    return data;
  }
}
