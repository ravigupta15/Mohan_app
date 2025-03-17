import 'package:mohan_impex/features/home_module/price_list/model/price_list_model.dart';
import 'package:mohan_impex/features/home_module/price_list/riverpod/price_list_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class PriceListState {
  final bool isLoading;
  PriceListModel? priceListModel;
  int currentPage;
  bool isLoadingMore;
  PriceListState({required this.isLoading, this.priceListModel,this.currentPage = 1, this.isLoadingMore=false});

  PriceListState copyWith({  bool? isLoading, PriceListModel? priceListModel,
  int? currentPage,
  bool? isLoadingMore
  }) {
    return PriceListState(
      isLoading: isLoading??this.isLoading,
      priceListModel: priceListModel??this.priceListModel,
      currentPage: currentPage??this.currentPage,
      isLoadingMore: isLoadingMore??this.isLoadingMore
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final priceListProvider  =StateNotifierProvider<PriceListNotifier,PriceListState>((ref)=>PriceListNotifier());
