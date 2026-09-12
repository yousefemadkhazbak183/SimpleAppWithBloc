part of 'product_cubit.dart';

@immutable
sealed class ProductState extends Equatable {
  const ProductState();
}

final class ProductLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

final class ProductLoaded extends ProductState {
  final List<ProductModel> productList;
  const ProductLoaded(this.productList);

  @override
  List<Object?> get props => [productList];
}

final class ProductFailure extends ProductState {
  final String errorMessage;
  const ProductFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
