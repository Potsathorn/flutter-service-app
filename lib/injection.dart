import 'package:get_it/get_it.dart';
import 'package:service_app/data/datasources/local/local_data_source.dart';
import 'package:service_app/data/datasources/remote/remote_data_source.dart';
import 'package:service_app/data/repositories/service_data_repository_impl.dart';
import 'package:service_app/data/repositories/shop_data_repository_impl.dart';
import 'package:service_app/domain/repositories/service_data_repository.dart';
import 'package:service_app/domain/repositories/shop_data_repository.dart';
import 'package:service_app/domain/usecase/crud_service_data.dart';
import 'package:service_app/domain/usecase/get_shop_data.dart';
import 'package:service_app/presentation/provider/service_data/service_data_notifier.dart';
import 'package:service_app/presentation/provider/shop_data/shop_data_notifier.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  //provider
  locator.registerFactory(() => ShopDataNotifier(locator()));
  locator.registerFactory(() => ServiceDataNotifier(locator()));

  //usecase
  locator.registerLazySingleton(() => GetShopData(locator()));
  locator.registerLazySingleton(() => CrudServiceData(locator()));

  //repository
  locator.registerLazySingleton<ShopDataRepository>(
      () => ShopDataRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<ServiceDataRepository>(
      () => ServiceDataRepositoryImpl(localDataSource: locator()));

  //data source
  locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  //remote
  locator.registerLazySingleton(() => http.Client());

  //local
  LocalDataSource.initialize();
}
