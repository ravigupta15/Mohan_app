// class JounreyPlanModel {
//   bool? status;
//   String? message;
// List<Data>? data;

//   JounreyPlanModel({this.message});

//   JounreyPlanModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add( Data.fromJson(v));
//       });
//     }}

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  Map<String, dynamic>();
//     data['status'] = status;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   List<Pending>? approved;
//   List<Pending>? pending;
//   dynamic createPerm;

//   Data({this.approved, this.pending, this.createPerm});

//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['approved'] != null) {
//       approved = <Pending>[];
//       json['approved'].forEach((v) {
//         approved!.add( Pending.fromJson(v));
//       });
//     }
//     if (json['pending'] != null) {
//       pending = <Pending>[];
//       json['pending'].forEach((v) {
//         pending!.add( Pending.fromJson(v));
//       });
//     }
//     createPerm = json['create_perm'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (approved != null) {
//       data['approved'] = approved!.map((v) => v.toJson()).toList();
//     }
//     if (pending != null) {
//       data['pending'] = pending!.map((v) => v.toJson()).toList();
//     }
//     data['create_perm'] = createPerm;
//     return data;
//   }
// }

// class Pending {
//   dynamic name;
//   dynamic approvedDate;
//   dynamic status;
//   dynamic formUrl;

//   Pending({this.name, this.approvedDate, this.status, this.formUrl});

//   Pending.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     approvedDate = json['approved_date'];
//     status = json['status'];
//     formUrl = json['form_url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  Map<String, dynamic>();
//     data['name'] = name;
//     data['approved_date'] = approvedDate;
//     data['status'] = status;
//     data['form_url'] = formUrl;
//     return data;
//   }
// }
