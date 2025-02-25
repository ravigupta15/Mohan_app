import 'package:mohan_impex/features/home_module/price_list/model/price_list_model.dart';
import 'package:mohan_impex/features/home_module/price_list/riverpod/price_list_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class PriceListState {
  final bool isLoading;
  PriceListModel? priceListModel;
  PriceListState({required this.isLoading, this.priceListModel});

  PriceListState copyWith({  bool? isLoading, PriceListModel? priceListModel}) {
    return PriceListState(
      isLoading: isLoading??this.isLoading,
      priceListModel: priceListModel??this.priceListModel
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final priceListProvider  =StateNotifierProvider<PriceListNotifier,PriceListState>((ref)=>PriceListNotifier());
