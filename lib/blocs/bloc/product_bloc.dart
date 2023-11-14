// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sprout/model/product_details.dart';
import 'package:sprout/model/product_list_model.dart';
import 'package:sprout/repository/data_provider.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService _productService;
  int skip;
  final int limit = 10;
  ProductBloc(this._productService, this.skip)
      : super(const ProductLoadingState()) {
    on<ProductEvent>((event, emit) async {
      if (event is LoadProductEvent) {
        emit(ProductLoadingState());
        try {
          final productList = await _productService.fetchProducts(skip, limit);
          emit(ProductLoadedState(productList));
        } catch (e) {
          emit(LoadingErrorState(e.toString()));
        }
      } else if (event is RefreshProductEvent) {
        emit(ProductLoadingState());
        skip = event.skipNum;
        try {
          final productList = await _productService.fetchProducts(skip, limit);
          emit(ProductLoadedState(productList));
        } catch (e) {
          emit(LoadingErrorState(e.toString()));
        }
      }
    });
  }
}

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final ProductService? _productService;
  final int? productID;

  ProductDetailsBloc(this._productService, this.productID)
      : super(const ProductDetailsLoadingState()) {
    on<ProductDetailsEvent>((event, emit) async {
      emit(ProductDetailsLoadingState());
      try {
        if (productID != null) {
          final productList =
              await _productService!.fetchProductsDetails(productID!);
          emit(ProductDetailsLoadedState(productList));
        } else {
          emit(ProductDetailsErrorState("Product ID is null"));
        }
      } catch (e) {
        emit(ProductDetailsErrorState(e.toString()));
      }
    });
  }
}
