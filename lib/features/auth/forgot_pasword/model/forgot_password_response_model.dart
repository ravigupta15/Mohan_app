class ForgotPasswordResponseModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  ForgotPasswordResponseModel({this.status, this.message, this.data});

  ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
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
   String? otp;

  Data(
      {this.otp});

  Data.fromJson(Map<String, dynamic> json) {
    otp = json['otp'] as String? ??"";
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['otp'] = otp;
    return data;
  }
}
