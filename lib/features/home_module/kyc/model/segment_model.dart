class SegmentModel {
  List<SegmentItemModel>? data;

  SegmentModel({this.data});

  SegmentModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SegmentItemModel>[];
      json['data'].forEach((v) {
        data!.add( SegmentItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SegmentItemModel {
  dynamic name;

  SegmentItemModel({this.name});

  SegmentItemModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    return data;
  }
}
