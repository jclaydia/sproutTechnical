part of 'product_bloc.dart';

@immutable
class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object> get props => [];
}

class ProductLoadingState extends ProductState {
  const ProductLoadingState();
}

class ProductLoadedState extends ProductState {
  final List<Product>? product;
  const ProductLoadedState(
    this.product,
  );
}

class LoadingErrorState extends ProductState {
  final String error;
  const LoadingErrorState(
    this.error,
  );
}

class ProductDetailsState extends Equatable {
  const ProductDetailsState();
  @override
  List<Object> get props => [];
}

class ProductDetailsLoadingState extends ProductDetailsState {
  const ProductDetailsLoadingState();
}

class ProductDetailsLoadedState extends ProductDetailsState {
  final ProductDetails products;
  const ProductDetailsLoadedState(this.products);
}

class ProductDetailsErrorState extends ProductDetailsState {
  final String error;
  const ProductDetailsErrorState(this.error);
}
