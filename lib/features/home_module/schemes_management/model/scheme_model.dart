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
  dynamic title;
  dynamic schemeType;
  dynamic description;
  dynamic discountPercentage;
  dynamic termsAndConditions;
  dynamic validUpto;
  dynamic minQty;

  Data(
      {this.title,
      this.schemeType,
      this.description,
      this.discountPercentage,
      this.termsAndConditions,
      this.validUpto,
      this.minQty});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    schemeType = json['scheme_type'];
    description = json['description'];
    discountPercentage = json['discount_percentage'];
    termsAndConditions = json['terms_and_conditions'];
    validUpto = json['valid_upto'];
    minQty = json['min_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = title;
    data['scheme_type'] = schemeType;
    data['description'] = description;
    data['discount_percentage'] = discountPercentage;
    data['terms_and_conditions'] = termsAndConditions;
    data['valid_upto'] = validUpto;
    data['min_qty'] = minQty;
    return data;
  }
}
