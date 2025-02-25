import 'package:mohan_impex/features/home_module/schemes_management/model/scheme_model.dart';
import 'package:mohan_impex/features/home_module/schemes_management/riverpod/schemes_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class SchemesState {
  final bool isLoading;
  SchemeModel? schemeModel;
  SchemesState({required this.isLoading, this.schemeModel});

  SchemesState copyWith({  bool? isLoading, SchemeModel? schemeModel}) {
    return SchemesState(
      isLoading: isLoading??this.isLoading,
      schemeModel: schemeModel??this.schemeModel
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final schemesProvider  =StateNotifierProvider<SchemesNotifier,SchemesState>((ref)=>SchemesNotifier());
