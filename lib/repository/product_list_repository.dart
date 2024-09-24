import 'dart:io';

import 'package:rs_productapp_project/configs/api_constants.dart';
import 'package:rs_productapp_project/data/exceptions/app_exceptions.dart';
import 'package:rs_productapp_project/data/network/network_api_service.dart';
import 'package:rs_productapp_project/di/get_it.dart';
import 'package:rs_productapp_project/models/product_details_model.dart';

class ProductListRepository {
  Future<List<ProductDetailsModel>> getProductListData() async {
    try {
      // Assuming this service returns a list of products
      final response = await getItInstance<NetworkApiService>().getProductListData(ApiConstants.productListUrl);
      
      // Check if response is a list and map it to ProductDetailsModel objects
      if (response is List) {
        return response.map((item) => ProductDetailsModel.fromJson(item)).toList();
      } else {
        throw FormatException('Expected a list but got ${response.runtimeType}');
      }
    } on SocketException {
      throw InternetException('No Internet Connection');
    } on WebSocketException {
      throw InternetException('No Internet Connection');
    }
  }
}