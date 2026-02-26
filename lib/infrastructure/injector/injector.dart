import 'package:boilerplate/core/network/api_client.dart';
import 'package:boilerplate/core/network/api_endpoints.dart';
import 'package:boilerplate/features/home/data/datasources/local_datasource.dart';
import 'package:boilerplate/features/home/data/repositories/repository.dart';
import 'package:boilerplate/features/home/domain/repositories/repository.dart';
import 'package:boilerplate/features/home/presentation/blocs/bloc.dart';
import 'package:boilerplate/features/settings/presentation/blocs/settings_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

void setupInjector({required SharedPreferences prefs}) {
  sl.registerSingleton<SharedPreferences>(prefs);

  sl.registerLazySingleton<DreamLocalDataSource>(
    () => DreamLocalDataSourceImpl(sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<IDreamRepository>(
    () => DreamRepositoryImpl(sl<DreamLocalDataSource>()),
  );

  sl.registerFactory<DreamsCubit>(
    () => DreamsCubit(sl<IDreamRepository>()),
  );

  // Singleton so all widgets share the same settings state.
  sl.registerLazySingleton<SettingsCubit>(
    () => SettingsCubit(sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(baseUrl: ApiEndpoints.baseURL, useAuth: true, timeout: 5000),
  );
}
