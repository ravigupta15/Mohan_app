import 'package:mohan_impex/features/home_module/kyc/model/activity_model.dart';

class ViewKycModel {
  dynamic status;
  String? message;
  List<Data>? data;

  ViewKycModel({this.status, this.message, this.data});

  ViewKycModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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
  dynamic name;
  dynamic workflowState;
  dynamic namingSeries;
  dynamic salutation;
  dynamic customerName;
  dynamic customerType;
  dynamic customerLevel;
  dynamic customerGroup;
  dynamic customCustomerCategory;
  dynamic businessType;
  dynamic customShop;
  dynamic customChannelPartner;
  dynamic ticketNo;
  dynamic ticketNumber;
  dynamic requestDate;
  dynamic territory;
  dynamic gender;
  dynamic leadName;
 dynamic opportunityName;
  dynamic prospectName;
  dynamic accountManager;
  dynamic image;
  dynamic customKycStatus;
  dynamic district;
  dynamic state;
  dynamic customSe;
  dynamic customSm;
  dynamic customAsm;
  dynamic customSalesDivision;
  dynamic defaultCurrency;
  dynamic defaultBankAccount;
  dynamic defaultPriceList;
  dynamic isInternalCustomer;
  dynamic representsCompany;
  dynamic marketSegment;
  dynamic industry;
  dynamic customerPosId;
  dynamic website;
  dynamic language;
  dynamic customerDetails;
  dynamic customerPrimaryAddress;
  dynamic primaryAddress;
  dynamic customerPrimaryContact;
  dynamic mobileNo;
  dynamic emailId;
  dynamic taxId;
  dynamic taxCategory;
  dynamic taxWithholdingCategory;
  dynamic gstin;
  dynamic pan;
  dynamic gstCategory;
  dynamic paymentTerms;
  dynamic loyaltyProgram;
  dynamic loyaltyProgramTier;
  dynamic defaultSalesPartner;
  dynamic defaultCommissionRate;
  dynamic soRequired;
  dynamic dnRequired;
  dynamic isFrozen;
  dynamic disabled;
  List<CustLicense>? customerLicense;
  List? accounts;
  List? portalUsers;
  List? salesTeam;
  List? creditLimits;
  List<CustDecl>? custDecl;
  List? companies;
  List<BillingAddress>? billingAddress;
  List<BillingAddress>? shippingAddress;
  List<Activities>? activities;
  List<String>? contact;
  Data(
      {this.name,
      this.workflowState,
      this.namingSeries,
      this.salutation,
      this.customerName,
      this.customerType,
      this.customerLevel,
      this.customerGroup,
      this.customCustomerCategory,
      this.businessType,
      this.customShop,
      this.customChannelPartner,
      this.ticketNo,
      this.ticketNumber,
      this.requestDate,
      this.territory,
      this.gender,
      this.leadName,
      this.opportunityName,
      this.prospectName,
      this.accountManager,
      this.image,
      this.customKycStatus,
      this.district,
      this.state,
      this.customSe,
      this.customSm,
      this.customAsm,
      this.customSalesDivision,
      this.defaultCurrency,
      this.defaultBankAccount,
      this.defaultPriceList,
      this.isInternalCustomer,
      this.representsCompany,
      this.marketSegment,
      this.industry,
      this.customerPosId,
      this.website,
      this.language,
      this.customerDetails,
      this.customerPrimaryAddress,
      this.primaryAddress,
      this.customerPrimaryContact,
      this.mobileNo,
      this.emailId,
      this.taxId,
      this.taxCategory,
      this.taxWithholdingCategory,
      this.gstin,
      this.pan,
      this.gstCategory,
      this.paymentTerms,
      this.loyaltyProgram,
      this.loyaltyProgramTier,
      this.defaultSalesPartner,
      this.defaultCommissionRate,
      this.soRequired,
      this.dnRequired,
      this.isFrozen,
      this.disabled,
      this.customerLicense,
      this.accounts,
      this.portalUsers,
      this.salesTeam,
      this.creditLimits,
      this.custDecl,
      this.companies,
      this.billingAddress,
      this.shippingAddress,
      this.activities,
      this.contact});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    workflowState = json['workflow_state'];
    namingSeries = json['naming_series'];
    salutation = json['salutation'];
    customerName = json['customer_name'];
    customerType = json['customer_type'];
    customerLevel = json['customer_level'];
    customerGroup = json['customer_group'];
    customCustomerCategory = json['custom_customer_category'];
    businessType = json['business_type'];
    customShop = json['custom_shop'];
    customChannelPartner = json['custom_channel_partner'];
    ticketNo = json['ticket_no'];
    ticketNumber = json['ticket_number'];
    requestDate = json['request_date'];
    territory = json['territory'];
    gender = json['gender'];
    leadName = json['lead_name'];
    opportunityName = json['opportunity_name'];
    prospectName = json['prospect_name'];
    accountManager = json['account_manager'];
    image = json['image'];
    customKycStatus = json['custom_kyc_status'];
    district = json['district'];
    state = json['state'];
    customSe = json['custom_se'];
    customSm = json['custom_sm'];
    customAsm = json['custom_asm'];
    customSalesDivision = json['custom_sales_division'];
    defaultCurrency = json['default_currency'];
    defaultBankAccount = json['default_bank_account'];
    defaultPriceList = json['default_price_list'];
    isInternalCustomer = json['is_internal_customer'];
    representsCompany = json['represents_company'];
    marketSegment = json['market_segment'];
    industry = json['industry'];
    customerPosId = json['customer_pos_id'];
    website = json['website'];
    language = json['language'];
    customerDetails = json['customer_details'];
    customerPrimaryAddress = json['customer_primary_address'];
    primaryAddress = json['primary_address'];
    customerPrimaryContact = json['customer_primary_contact'];
    mobileNo = json['mobile_no'];
    emailId = json['email_id'];
    taxId = json['tax_id'];
    taxCategory = json['tax_category'];
    taxWithholdingCategory = json['tax_withholding_category'];
    gstin = json['gstin'];
    pan = json['pan'];
    gstCategory = json['gst_category'];
    paymentTerms = json['payment_terms'];
    loyaltyProgram = json['loyalty_program'];
    loyaltyProgramTier = json['loyalty_program_tier'];
    defaultSalesPartner = json['default_sales_partner'];
    defaultCommissionRate = json['default_commission_rate'];
    soRequired = json['so_required'];
    dnRequired = json['dn_required'];
    isFrozen = json['is_frozen'];
    disabled = json['disabled'];
    if (json['cust_decl'] != null) {
      custDecl = <CustDecl>[];
      json['cust_decl'].forEach((v) {
        custDecl!.add(new CustDecl.fromJson(v));
      });
    }
     if (json['customer_license'] != null) {
      customerLicense = <CustLicense>[];
      json['customer_license'].forEach((v) {
        customerLicense!.add(CustLicense.fromJson(v));
      });
    }
    if (json['billing_address'] != null) {
      billingAddress = <BillingAddress>[];
      json['billing_address'].forEach((v) {
        billingAddress!.add(new BillingAddress.fromJson(v));
      });
    }
    if (json['shipping_address'] != null) {
      shippingAddress = <BillingAddress>[];
      json['shipping_address'].forEach((v) {
        shippingAddress!.add(BillingAddress.fromJson(v));
      });
    }
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add( Activities.fromJson(v));
      });
    }
    contact = json['contact'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['workflow_state'] = workflowState;
    data['naming_series'] = namingSeries;
    data['salutation'] = salutation;
    data['customer_name'] = customerName;
    data['customer_type'] = customerType;
    data['customer_level'] = customerLevel;
    data['customer_group'] = customerGroup;
    data['custom_customer_category'] = customCustomerCategory;
    data['business_type'] = businessType;
    data['custom_shop'] = customShop;
    data['custom_channel_partner'] = customChannelPartner;
    data['ticket_no'] = ticketNo;
    data['ticket_number'] = ticketNumber;
    data['request_date'] = requestDate;
    data['territory'] = territory;
    data['gender'] = gender;
    data['lead_name'] = leadName;
    data['opportunity_name'] = opportunityName;
    data['prospect_name'] = prospectName;
    data['account_manager'] = accountManager;
    data['image'] = image;
    data['custom_kyc_status'] = customKycStatus;
    data['district'] = district;
    data['state'] = state;
    data['custom_se'] = customSe;
    data['custom_sm'] = customSm;
    data['custom_asm'] = customAsm;
    data['custom_sales_division'] = customSalesDivision;
    data['default_currency'] = defaultCurrency;
    data['default_bank_account'] = defaultBankAccount;
    data['default_price_list'] = defaultPriceList;
    data['is_internal_customer'] = isInternalCustomer;
    data['represents_company'] = representsCompany;
    data['market_segment'] = marketSegment;
    data['industry'] = industry;
    data['customer_pos_id'] = customerPosId;
    data['website'] = website;
    data['language'] = language;
    data['customer_details'] = customerDetails;
    data['customer_primary_address'] = customerPrimaryAddress;
    data['primary_address'] = primaryAddress;
    data['customer_primary_contact'] = customerPrimaryContact;
    data['mobile_no'] = mobileNo;
    data['email_id'] = emailId;
    data['tax_id'] = taxId;
    data['tax_category'] = taxCategory;
    data['tax_withholding_category'] = taxWithholdingCategory;
    data['gstin'] = gstin;
    data['pan'] = pan;
    data['gst_category'] = gstCategory;
    data['payment_terms'] = paymentTerms;
    data['loyalty_program'] = loyaltyProgram;
    data['loyalty_program_tier'] = loyaltyProgramTier;
    data['default_sales_partner'] = defaultSalesPartner;
    data['default_commission_rate'] = defaultCommissionRate;
    data['so_required'] = soRequired;
    data['dn_required'] = dnRequired;
    data['is_frozen'] = isFrozen;
    data['disabled'] = disabled;
     if (custDecl != null) {
      data['cust_decl'] = custDecl!.map((v) => v.toJson()).toList();
    }    if (accounts != null) {
      data['accounts'] = accounts!.map((v) => v.toJson()).toList();
    }
     if (customerLicense != null) {
      data['customer_license'] =
          customerLicense!.map((v) => v.toJson()).toList();
    }
    if (billingAddress != null) {
      data['billing_address'] =
          billingAddress!.map((v) => v.toJson()).toList();
    }
    if (shippingAddress != null) {
      data['shipping_address'] =
          shippingAddress!.map((v) => v.toJson()).toList();
    }
    
    if (activities != null) {
      data['activities'] = activities!.map((v) => v.toJson()).toList();
    }
    data['contact'] = contact;
    return data;
  }
}

class CustDecl {
  dynamic name;
  dynamic custDecl;

  CustDecl({this.name, this.custDecl});

  CustDecl.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    custDecl = json['cust_decl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['cust_decl'] = custDecl;
    return data;
  }
}


class CustLicense {
  dynamic name;
  dynamic custDecl;

  CustLicense({this.name, this.custDecl});

  CustLicense.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    custDecl = json['cust_lic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['cust_lic'] = custDecl;
    return data;
  }
}

class BillingAddress {
  dynamic addressTitle;
  dynamic addressLine1;
  dynamic addressLine2;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic pincode;

  BillingAddress(
      {this.addressTitle,
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.state,
      this.country,
      this.pincode});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    addressTitle = json['address_title'] ?? '';
    addressLine1 = json['address_line1'] ?? '';
    addressLine2 = json['address_line2'] ?? '';
    city = json['city'] ?? '';
    state = json['state'] ?? '';
    country = json['country'] ?? '';
    pincode = json['pincode'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['address_title'] = addressTitle;
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['pincode'] = pincode;
    return data;
  }
}
