class DistrictModel {
  List<DistrictItem>? data;

  DistrictModel({this.data});

  DistrictModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DistrictItem>[];
      json['data'].forEach((v) {
        data!.add(new DistrictItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DistrictItem {
  String? district;
  String? state;

  DistrictItem({this.district, this.state});

  DistrictItem.fromJson(Map<String, dynamic> json) {
    district = json['district'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['district'] = district;
    data['state'] = state;
    return data;
  }
}
