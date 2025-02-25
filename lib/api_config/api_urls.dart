class ApiUrls {
  static const baseUrl = "http://4.186.63.57/api/";

  /// auth
  static const generateOtpUrl = "${baseUrl}method/mohan_impex.api.auth.generate_otp";
  static const loginUrl = "${baseUrl}method/mohan_impex.api.auth.login";
  static const otpVerifyUrl = "${baseUrl}method/mohan_impex.api.auth.validate_otp";
  static const updateResetPasswordUrl = "${baseUrl}method/mohan_impex.api.auth.reset_password";
 
 /// logout
 static const logoutUrl = "${baseUrl}method/mohan_impex.api.auth.logout";

 /// dashboard
 static const dashboardUrl = "${baseUrl}method/mohan_impex.api.dashboard";
 static const checkInUrl = "${baseUrl}method/mohan_impex.api.checkin";

/// image upload
static const imageUploadUrl = "${baseUrl}method/mohan_impex.api.cvm.capture_image";

 /// custom visit
 static const customVisitListUrl = "${baseUrl}method/mohan_impex.api.cvm.cvm_list";
 static const createCVMurl =  "${baseUrl}mohan_impex.api.cvm.create_cvm";
 
 /// product trial
 static const productTrialUrl = "${baseUrl}method/mohan_impex.api.product_trial.create_product_trial";
 static const trialPlanUrl = "${baseUrl}method/mohan_impex.api.product_trial.trial_list";

 /// price list
 static const priceListUrl = "${baseUrl}method/mohan_impex.api.price_list.price_list";

 /// kyc
 static const kycList = "${baseUrl}method/mohan_impex.api.kyc.kyc_list";
 static const uploadKycAttachementUrl = "${baseUrl}method/mohan_impex.api.upload_attachments";
 static const createKycUrl = "${baseUrl}mohan_impex.api.kyc.create_kyc";

 /// scheme 
 static const schemeListUrl = "${baseUrl}method/mohan_impex.api.scheme.scheme_list";

 // complaint
 static const createComplaintUrl = "${baseUrl}method/mohan_impex.api.complaints.create_complaint";
 static const uploadComplaintImageUrl = "${baseUrl}method/mohan_impex.api.upload_attachments";
 static const complaintListUrl = "${baseUrl}method/mohan_impex.api.complaints.complaints_list";
 static const viewComplaintUrl = "${baseUrl}method/mohan_impex.api.complaints.complaints_form";

 /// master 
 static const itemListUrl = "${baseUrl}resource/Item";
 static const channelPartnerurl = "${baseUrl}method/mohan_impex.api.get_channel_partner";
 static const shopUrl = "${baseUrl}method/mohan_impex.api.get_shops";
 static const competitorUrl = "${baseUrl}resource/Competitor";
 static const productUrl = "${baseUrl}resource/Product/";
 static const productItemUrl = "${baseUrl}method/mohan_impex.api.get_items";
 static const productCategoryUrl = "${baseUrl}resource/Product Category";
 static const getCustomerurl = "${baseUrl}method/mohan_impex.api.get_customer_info";

 // journey
 static const createJourneyUrl = "${baseUrl}method/mohan_impex.api.journey_plan.create_journey_plan";
 static const journeyPlanListUrl = "${baseUrl}method/mohan_impex.api.journey_plan.journey_plan_list";
 static const viewJourneyPlanUrl = "${baseUrl}method/mohan_impex.api.journey_plan.journey_plan_form";
 static const stateUrl = "${baseUrl}resource/State";
 static const districtUrl = "${baseUrl}resource/District";

 /// sample
 static const sampleReuisitionsListUrl = "${baseUrl}method/mohan_impex.api.sample.sample_list";
 static const viewSampleRequisitionsUrl = "${baseUrl}method/mohan_impex.api.sample.sample_form";
 static const createSampleRequisitionsUrl = "${baseUrl}method/mohan_impex.api.sample.create_sample";

/// collateral marking
static const materialListUrl = "${baseUrl}method/mohan_impex.api.material_list";
static const createCollateralRequestUrl = "${baseUrl}method/mohan_impex.api.collateral_request.create_collateral_request";
static const collateralRequestListUrl = "${baseUrl}method/mohan_impex.api.collateral_request.collateral_request_list";
static const viewCollateralUrl = "${baseUrl}method/mohan_impex.api.collateral_request.collateral_request_form";

/// digital marking
static const digitalMarkingCollateralsUrl = "${baseUrl}method/mohan_impex.api.marketing_collateral.digital_mc_list";
}