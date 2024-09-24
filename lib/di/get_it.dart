import 'package:get_it/get_it.dart';
import 'package:rs_productapp_project/data/network/network_api_service.dart';
import 'package:rs_productapp_project/repository/product_list_repository.dart';

final getItInstance = GetIt.instance;

Future init() async {

  getItInstance.registerLazySingleton<NetworkApiService>(() => NetworkApiService());

  getItInstance
      .registerLazySingleton<ProductListRepository>(() => ProductListRepository());

}