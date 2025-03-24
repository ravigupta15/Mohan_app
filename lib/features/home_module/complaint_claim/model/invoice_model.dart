class InvoiceModel {
  dynamic status;
  dynamic message;
  List<invoiceListModel>? data;

  InvoiceModel({this.status, this.message, this.data});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <invoiceListModel>[];
      json['data'].forEach((v) {
        data!.add( invoiceListModel.fromJson(v));
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

class invoiceListModel {
  dynamic name;
  dynamic date;

  invoiceListModel({this.name, this.date});

  invoiceListModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['date'] = date;
    return data;
  }
}
