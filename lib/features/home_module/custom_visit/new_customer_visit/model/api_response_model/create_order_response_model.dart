class CreateOrderResponseModel {
  bool? status;
  String? message;
  List<Data>? data;

  CreateOrderResponseModel({this.status, this.message, this.data});

  CreateOrderResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? cvm;

  Data({this.cvm});

  Data.fromJson(Map<String, dynamic> json) {
    cvm = json['cvm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['cvm'] = cvm;
    return data;
  }
}
