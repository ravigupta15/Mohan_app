import 'package:mohan_impex/features/home_module/custom_visit/model/customer_visit_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/riverpod/customer_visit_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class CustomerVisitState {
  final bool isLoading;
  CustomerVisitModel? customerVisitModel;
  CustomerVisitState({required this.isLoading, this.customerVisitModel});

  CustomerVisitState copyWith({  bool? isLoading, CustomerVisitModel? customerVisitModel}) {
    return CustomerVisitState(
      isLoading: isLoading??this.isLoading,
      customerVisitModel: customerVisitModel??this.customerVisitModel
    );
  }
}



final customVisitProvider  =StateNotifierProvider<CustomerVisitNotifier,CustomerVisitState>((ref)=>CustomerVisitNotifier());
