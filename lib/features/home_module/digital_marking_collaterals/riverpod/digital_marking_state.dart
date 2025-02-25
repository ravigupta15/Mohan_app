import 'package:mohan_impex/features/home_module/digital_marking_collaterals/model/digital_markting_model.dart';
import 'package:mohan_impex/features/home_module/digital_marking_collaterals/riverpod/digital_marking_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class DigitalMarkingState {
  final bool isLoading;
  DigitalMarkingModel? digitalMarkingModel;
  DigitalMarkingState({required this.isLoading, this.digitalMarkingModel});

  DigitalMarkingState copyWith({  bool? isLoading, DigitalMarkingModel? digitalMarkingModel}) {
    return DigitalMarkingState(
      isLoading: isLoading??this.isLoading,
      digitalMarkingModel: digitalMarkingModel??this.digitalMarkingModel
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final digitalMarkingProvider  =StateNotifierProvider<DigitalMarkingNotifier,DigitalMarkingState>((ref)=>DigitalMarkingNotifier());
