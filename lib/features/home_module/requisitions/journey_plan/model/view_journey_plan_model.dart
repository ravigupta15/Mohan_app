import 'package:mohan_impex/features/home_module/kyc/model/activity_model.dart';

class ViewJounreyPlanModel {
  dynamic status;
  String? message;
  List<JourneyDetailsModel>? data;

  ViewJounreyPlanModel({this.status, this.message, this.data});

  ViewJounreyPlanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <JourneyDetailsModel>[];
      json['data'].forEach((v) {
        data!.add( JourneyDetailsModel.fromJson(v));
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

class JourneyDetailsModel {
  dynamic name;
  dynamic owner;
  dynamic creation;
  dynamic modified;
  dynamic modifiedBy;
  dynamic docstatus;
  dynamic idx;
  dynamic visitFromDate;
  dynamic natureOfTravel;
  dynamic modeOfTravel;
  dynamic approvedDate;
  dynamic visitToDate;
  dynamic nightOutLocation;
  dynamic travelToState;
  dynamic travelToDistrict;
  dynamic status;
  dynamic remarks;
  dynamic amendedFrom;
  dynamic createdByEmp;
  dynamic area;
  dynamic workflowState;
  dynamic doctype;
  List<Activities>? activities;

  JourneyDetailsModel(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.visitFromDate,
      this.natureOfTravel,
      this.modeOfTravel,
      this.approvedDate,
      this.visitToDate,
      this.nightOutLocation,
      this.travelToState,
      this.travelToDistrict,
      this.status,
      this.remarks,
      this.amendedFrom,
      this.createdByEmp,
      this.area,
      this.workflowState,
      this.doctype,
      this.activities});

  JourneyDetailsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    visitFromDate = json['visit_from_date'];
    natureOfTravel = json['nature_of_travel'];
    modeOfTravel = json['mode_of_travel'];
    approvedDate = json['approved_date'];
    visitToDate = json['visit_to_date'];
    nightOutLocation = json['night_out_location'];
    travelToState = json['travel_to_state'];
    travelToDistrict = json['travel_to_district'];
    status = json['status'];
    remarks = json['remarks'];
    amendedFrom = json['amended_from'];
    createdByEmp = json['created_by_emp'];
    area = json['area'];
    workflowState = json['workflow_state'];
    doctype = json['doctype'];
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(new Activities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['owner'] = owner;
    data['creation'] = creation;
    data['modified'] = modified;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['visit_from_date'] = visitFromDate;
    data['nature_of_travel'] = natureOfTravel;
    data['mode_of_travel'] = modeOfTravel;
    data['approved_date'] = approvedDate;
    data['visit_to_date'] = visitToDate;
    data['night_out_location'] = nightOutLocation;
    data['travel_to_state'] = travelToState;
    data['travel_to_district'] = travelToDistrict;
    data['status'] = status;
    data['remarks'] = remarks;
    data['amended_from'] = amendedFrom;
    data['created_by_emp'] = createdByEmp;
    data['area'] = area;
    data['workflow_state'] = workflowState;
    data['doctype'] = doctype;
    if (activities != null) {
      data['activities'] = activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
