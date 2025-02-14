
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/home_module/home/model/dashboard_model.dart';
import 'package:mohan_impex/features/home_module/home/riverpod/home_state.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(HomeState(isLoading: false));
updateLoading(bool value){
  state= state.copyWith(isLoading: value);
}


checkInApiFunction(String type)async{
  var data =  {
    "employee":LocalSharePreference.empId,
    "datetime":DateTime.now().toString(),
    "log_type":type.toUpperCase(),
    "latitude":LocalSharePreference.currentLatitude,
    "longitude":LocalSharePreference.currentLongitude
  };
  print(data);
  final response = await ApiService().makeRequest(apiUrl: ApiUrls.checkInUrl, method: ApiMethod.post.name,data:data);
   if(response!=null){
    // MessageHelper.showToast(response.data['message']['message']);
    dashboardApiFunction();
   }
}


dashboardApiFunction()async{
  final response = await ApiService().makeRequest(apiUrl: ApiUrls.dashboardUrl, method: ApiMethod.get.name);
   if(response!=null){
    state = state.copyWith(dashboardModel: DashboardModel.fromJson(response.data));
   }
 } 

}

