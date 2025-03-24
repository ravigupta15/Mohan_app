import 'package:mohan_impex/features/home_module/digital_marking_collaterals/model/digital_markting_model.dart';
import 'package:mohan_impex/features/home_module/digital_marking_collaterals/riverpod/digital_marking_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class DigitalMarkingState {
  final bool isLoading;
  DigitalMarkingModel? digitalMarkingModel;
  int currentPage;
   bool isLoadingMore;
  DigitalMarkingState({required this.isLoading, this.digitalMarkingModel,
  this.currentPage = 1, this.isLoadingMore =false
  });

  DigitalMarkingState copyWith({  bool? isLoading, DigitalMarkingModel? digitalMarkingModel,
  int? currentPage, bool? isLoadingMore}) {
    return DigitalMarkingState(
      isLoading: isLoading??this.isLoading,
      digitalMarkingModel: digitalMarkingModel??this.digitalMarkingModel,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ??  this.isLoadingMore
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final digitalMarkingProvider  =StateNotifierProvider<DigitalMarkingNotifier,DigitalMarkingState>((ref)=>DigitalMarkingNotifier());
