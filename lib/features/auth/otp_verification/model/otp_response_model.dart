class OtpResponseModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  OtpResponseModel({this.status, this.message, this.data});

  OtpResponseModel.fromJson(Map<String, dynamic> json) {
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
   String? resetPasswordKey;

  Data(
      {this.resetPasswordKey});

  Data.fromJson(Map<String, dynamic> json) {
    resetPasswordKey = json['pwd_reset_key'] as String? ??"";
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['pwd_reset_key'] = resetPasswordKey;
    return data;
  }
}
