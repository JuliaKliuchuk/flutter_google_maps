import 'package:get/get.dart';

import '../api_client.dart';

class MapRepo extends GetxService {
  final ApiClient apiClient;

  MapRepo({
    required this.apiClient,
  });
}
