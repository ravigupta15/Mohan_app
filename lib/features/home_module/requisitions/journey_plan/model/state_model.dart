class StateModel {
  List<StateItems>? data;

  StateModel({this.data});

  StateModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <StateItems>[];
      json['data'].forEach((v) {
        data!.add( StateItems.fromJson(v));
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

class StateItems {
  dynamic name;

  StateItems({this.name});

  StateItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    return data;
  }
}
