import 'package:bloc/bloc.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/product_remote_datasource.dart';
import 'package:fic9_ecommerce_template_app/data/models/response/products_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_event.dart';
part 'products_state.dart';
part 'products_bloc.freezed.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(const _Initial()) {
    on<_GetAll>((event, emit) async {
      emit(const _Loading());
      final response = await ProductRemoteDatasource().getAllProduct(event.token);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
