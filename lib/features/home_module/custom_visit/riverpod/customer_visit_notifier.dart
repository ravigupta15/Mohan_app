// Define a StateNotifier to manage the state
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/customer_visit_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/riverpod/customer_visit_state.dart';
import 'package:riverpod/riverpod.dart';


class CustomerVisitNotifier extends StateNotifier<CustomerVisitState> {
  CustomerVisitNotifier() : super(CustomerVisitState(isLoading: false));
 
 updateLoading(bool isLoading){
  state = state.copyWith(isLoading: isLoading);
}

customVisitApiFunction()async{
  updateLoading(true);
  final response = await ApiService().makeRequest(apiUrl: ApiUrls.customVisitListUrl, method: ApiMethod.get.name);
 updateLoading(false);
   if(response!=null){
    state = state.copyWith(customerVisitModel: CustomerVisitModel.fromJson(response.data));
   }
 } 
}
