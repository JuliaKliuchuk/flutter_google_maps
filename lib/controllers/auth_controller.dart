import 'package:flutter_google_maps/models/response_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../data/repository/auth_repo.dart';
import '../models/auth_model.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late Position _userPosition;
  Position get userPosition => _userPosition;

  Future<ResponseModel> registration(AuthModel data) async {
    _isLoading = true;
    update();

    Response response = await authRepo.registration(data);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      responseModel =
          ResponseModel(response.statusCode!, response.body['token']);
    } else {
      responseModel = ResponseModel(response.statusCode!, response.statusText!);
    }

    _isLoading = false;

    update();
    return responseModel;
  }

  Future<ResponseModel> login(String login, String password) async {
    _isLoading = true;
    update();

    Response response = await authRepo.login(login, password);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['data']['token']);

      responseModel =
          ResponseModel(response.statusCode!, response.body['data']['token']);
    } else {
      responseModel = ResponseModel(response.statusCode!, response.statusText!);
    }

    _isLoading = false;

    update();
    return responseModel;
  }

  getUserCurrentPosition() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _userPosition = position;
    });
  }
}
