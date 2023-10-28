import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../common/constants/variables.dart';
import '../models/response/products_response.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductsResponseModel>> getAllProduct(String token) async {
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/products?populate=*'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    );

    print("response: ${response.statusCode}");
    if (response.statusCode == 200) {
      return Right(ProductsResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }
}
