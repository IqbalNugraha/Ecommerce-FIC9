import 'package:fic9_ecommerce_template_app/common/constants/variables.dart';
import 'package:fic9_ecommerce_template_app/data/models/request/login_request_model.dart';
import 'package:fic9_ecommerce_template_app/data/models/request/register_request_model.dart';
import 'package:fic9_ecommerce_template_app/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

class AuthRemoteDatasource {
  final header = {'Content-Type': 'application/json'};
  Future<Either<String, AuthResponseModel>> register(
    RegisterRequestModel registerRequestModel,
  ) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/auth/local/register'),
      headers: header,
      body: registerRequestModel.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else if (response.statusCode == 400) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Service Error');
    }
  }

  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel loginRequestModel) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/auth/local'),
      headers: header,
      body: loginRequestModel.toJson(),
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else if (response.statusCode == 400) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Login Gagal');
    }
  }
}
