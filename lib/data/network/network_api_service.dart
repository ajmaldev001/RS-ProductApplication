import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rs_productapp_project/data/exceptions/app_exceptions.dart';
import 'package:rs_productapp_project/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices{
 
 dynamic responseJson;
 @override
  Future<dynamic> getProductListData(String url) async {
   try{
     final response = await http.get(Uri.parse(url));
     return responseJson = returnResponse(response);
   }catch(e){
     debugPrint('exception: $e');
   }
  }



  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 404:
        throw UnauthorizedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }
  
  }