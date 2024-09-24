import 'package:flutter/material.dart';
import 'package:rs_productapp_project/models/product_details_model.dart';
import 'package:rs_productapp_project/repository/product_list_repository.dart';

class ProductDetailsViewModel extends ChangeNotifier{
  final ProductListRepository _productListRepository = ProductListRepository();
  List<ProductDetailsModel?> productDetailsModel = [];
  String ratingCount = '';
  String ratingStar = '';
  int cartCount = 0;
  final Map<String,dynamic> _cartSelection = {};
  
  /* Product List API Call */
    Future fetchProductListData() async {
      try{
      final response = await _productListRepository.getProductListData();
      productDetailsModel = response;
      }catch(e){
        debugPrint('Error: $e');
      }
      notifyListeners();
    }

    void getRating(String id) {
      if(id.isNotEmpty){
        ratingCount = '';
        ratingStar = '';
      // Find the product with the matching id
      var product = productDetailsModel.firstWhere(
        (product) => product?.id.toString() == id,
        orElse: () => ProductDetailsModel(),
      );
      if (product != null) {
        ratingCount = product.rating?.count?.toString() ?? '';
        ratingStar = product.rating?.rate?.toString() ?? '';
      }
      notifyListeners();
      }
    }

    void addCartCount(String id){
      if(_cartSelection[id] == true){
        _cartSelection[id] = false;
        cartCount--;
      }else{
        _cartSelection[id] = true;
        cartCount++;
      }
    notifyListeners();
    }

    bool isInCart(String id){
      return _cartSelection[id] ?? false;
    }

}