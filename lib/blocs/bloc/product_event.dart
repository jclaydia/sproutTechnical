part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProductEvent extends ProductEvent {
  const LoadProductEvent();

  @override
  List<Object> get props => [];
}

class RefreshProductEvent extends ProductEvent {
  final int skipNum;
  const RefreshProductEvent(this.skipNum);

  @override
  List<Object> get props => [];
}

@immutable
abstract class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();
  @override
  List<Object> get props => [];
}

class LoadProductDetailsEvent extends ProductDetailsEvent {
  const LoadProductDetailsEvent();
  @override
  List<Object> get props => [];
}
