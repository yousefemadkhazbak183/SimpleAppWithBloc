import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_with_cubit_bloc/model/product_model.dart';
import 'package:to_do_app_with_cubit_bloc/repository/product_repo.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductLoading());
  ProductRepo productRepo = ProductRepo();

  getProduct() async {
    try {
      final List<ProductModel> products = await productRepo.getProductDate();
      emit(ProductLoaded(products));
    } on Exception catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }
}
