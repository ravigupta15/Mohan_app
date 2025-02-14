import 'package:mohan_impex/features/home_module/home/model/dashboard_model.dart';
import 'package:mohan_impex/features/home_module/home/riverpod/home_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class HomeState {
  final bool isLoading;
  DashboardModel? dashboardModel;
  HomeState({required this.isLoading, this.dashboardModel});

  HomeState copyWith({  bool? isLoading, DashboardModel? dashboardModel}) {
    return HomeState(
      isLoading: isLoading??this.isLoading,
      dashboardModel: dashboardModel??this.dashboardModel
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final homeProvider  =StateNotifierProvider<HomeNotifier,HomeState>((ref)=>HomeNotifier());
// final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>(
//   (ref) => HomeNotifier(),
// );
