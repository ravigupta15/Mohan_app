import 'package:mohan_impex/features/home_module/schemes_management/model/scheme_model.dart';
import 'package:mohan_impex/features/home_module/schemes_management/riverpod/schemes_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class SchemesState {
  final bool isLoading;
  SchemeModel? schemeModel;
  int currentPage;
  bool isLoadingMore;
  SchemesState({required this.isLoading, this.schemeModel, this.currentPage=1, this.isLoadingMore=false});

  SchemesState copyWith({  bool? isLoading, SchemeModel? schemeModel, bool? isLoadingMore, int? currentPage}) {
    return SchemesState(
      isLoading: isLoading??this.isLoading,
      schemeModel: schemeModel??this.schemeModel,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final schemesProvider  =StateNotifierProvider<SchemesNotifier,SchemesState>((ref)=>SchemesNotifier());
