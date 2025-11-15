import 'package:boilerplate/core/network/api_client.dart';
import 'package:boilerplate/core/network/api_endpoints.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupInjector() {
  sl.registerLazySingleton<ApiClient>(
    () =>
        ApiClient(baseUrl: ApiEndpoints.baseURL, useAuth: true, timeout: 5000),
  );
}
