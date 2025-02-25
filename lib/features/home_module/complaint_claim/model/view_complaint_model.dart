class ViewComplaintModel {
  dynamic status;
  String? message;
  List<ComplaintData>? data;

  ViewComplaintModel({this.status, this.message, this.data});

  ViewComplaintModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ComplaintData>[];
      json['data'].forEach((v) {
        data!.add( ComplaintData.fromJson(v));
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

class ComplaintData {
  dynamic name;
  dynamic owner;
  dynamic creation;
  dynamic modified;
  dynamic modifiedBy;
  dynamic docstatus;
  dynamic idx;
  dynamic workflowState;
  dynamic namingSeries;
  dynamic subject;
  dynamic claimType;
  dynamic raisedBy;
  dynamic status;
  dynamic customerType;
  dynamic company;
  dynamic customer;
  dynamic contact;
  dynamic state;
  dynamic town;
  dynamic pincode;
  dynamic mfd;
  dynamic createdByEmp;
  dynamic area;
  dynamic openingDate;
  dynamic openingTime;
  dynamic itemName;
  dynamic invoiceNo;
  dynamic complaintItmQty;
  dynamic valueOfGoods;
  dynamic batchNo;
  dynamic expiry;
  dynamic description;
  dynamic agreementStatus;
  dynamic viaCustomerPortal;
  dynamic doctype;
  dynamic invoiceDate;
List<ImageUrl>? imageUrl;
  ComplaintData(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.workflowState,
      this.namingSeries,
      this.subject,
      this.claimType,
      this.raisedBy,
      this.status,
      this.customerType,
      this.company,
      this.customer,
      this.contact,
      this.state,
      this.town,
      this.pincode,
      this.mfd,
      this.createdByEmp,
      this.area,
      this.openingDate,
      this.openingTime,
      this.itemName,
      this.invoiceNo,
      this.complaintItmQty,
      this.valueOfGoods,
      this.batchNo,
      this.expiry,
      this.description,
      this.agreementStatus,
      this.viaCustomerPortal,
      this.doctype,
      this.invoiceDate,
      this.imageUrl
      });

  ComplaintData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    workflowState = json['workflow_state'];
    namingSeries = json['naming_series'];
    subject = json['subject'];
    claimType = json['claim_type'];
    raisedBy = json['raised_by'];
    status = json['status'];
    customerType = json['customer_type'];
    company = json['company'];
    customer = json['customer'];
    contact = json['contact'];
    state = json['state'];
    town = json['town'];
    pincode = json['pincode'];
    mfd = json['mfd'];
    createdByEmp = json['created_by_emp'];
    area = json['area'];
    openingDate = json['opening_date'];
    openingTime = json['opening_time'];
    itemName = json['item_name'];
    invoiceNo = json['invoice_no'];
    complaintItmQty = json['complaint_itm_qty'];
    valueOfGoods = json['value_of_goods'];
    batchNo = json['batch_no'];
    expiry = json['expiry'];
    description = json['description'];
    agreementStatus = json['agreement_status'];
    viaCustomerPortal = json['via_customer_portal'];
    doctype = json['doctype'];
    invoiceDate = json['invoice_date'];
     if (json['image_url'] != null) {
      imageUrl = <ImageUrl>[];
      json['image_url'].forEach((v) {
        imageUrl!.add(new ImageUrl.fromJson(v));
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
    data['workflow_state'] = workflowState;
    data['naming_series'] = namingSeries;
    data['subject'] = subject;
    data['claim_type'] = claimType;
    data['raised_by'] = raisedBy;
    data['status'] = status;
    data['customer_type'] = customerType;
    data['company'] = company;
    data['customer'] = customer;
    data['contact'] = contact;
    data['state'] = state;
    data['town'] = town;
    data['pincode'] = pincode;
    data['mfd'] = mfd;
    data['created_by_emp'] = createdByEmp;
    data['area'] = area;
    data['opening_date'] = openingDate;
    data['opening_time'] = openingTime;
    data['item_name'] = itemName;
    data['invoice_no'] = invoiceNo;
    data['complaint_itm_qty'] = complaintItmQty;
    data['value_of_goods'] = valueOfGoods;
    data['batch_no'] = batchNo;
    data['expiry'] = expiry;
    data['description'] = description;
    data['agreement_status'] = agreementStatus;
    data['via_customer_portal'] = viaCustomerPortal;
    data['doctype'] = doctype;
    data['invoice_date']= invoiceDate;
    if (this.imageUrl != null) {
      data['image_url'] = this.imageUrl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class ImageUrl {
  dynamic fileName;
  dynamic fileUrl;

  ImageUrl({this.fileName, this.fileUrl});

  ImageUrl.fromJson(Map<String, dynamic> json) {
    fileName = json['file_name'];
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_name'] = fileName;
    data['file_url'] = fileUrl;
    return data;
  }
}