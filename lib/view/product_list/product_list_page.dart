import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_productapp_project/configs/colors/app_colors.dart';
import 'package:rs_productapp_project/configs/consts/image_contants.dart';
import 'package:rs_productapp_project/configs/consts/text_constants.dart';
import 'package:rs_productapp_project/services/auth_services.dart';
import 'package:rs_productapp_project/view/login/login_page.dart';
import 'package:rs_productapp_project/view/product_details/product_details_page.dart';
import 'package:rs_productapp_project/view/product_list/widget/product_listtile_widget.dart';
import 'package:rs_productapp_project/view/widgets/badge_widget.dart';
import 'package:rs_productapp_project/view_model/product_details_view_model.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products List'),
        backgroundColor: Colors.white,
         elevation: 0,
         centerTitle: false,
         automaticallyImplyLeading: false, // This removes the default back button
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: BadgeWidget(badgetCount: context.select<ProductDetailsViewModel,int>((value) => value.cartCount).toString(), 
            size: 24
            )
          ),
          TextButton(
              child: const Text("Log Out",style: TextStyle(fontSize: 16,color: AppColor.red),),
               onPressed: () async {
                _showLogoutDialog(context);
               },
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: context.read<ProductDetailsViewModel>().fetchProductListData(),
                builder: (context,snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator(color: AppColor.mildGrey,backgroundColor: AppColor.black,));
                  }else if(snapshot.hasError){
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImageConstants.emptyBoxImg),
                          const SizedBox(height: 4),
                          const Text('OOPS! Products Not Listed',style: TextStyle(fontSize: 18),)
                        ],
                      ),
                    );
                  } else{
                    return Consumer<ProductDetailsViewModel>(
                      builder: (context,productVM,child) {
                       final productDetails = productVM.productDetailsModel;
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                          child: ListView.builder(
                            itemCount: productDetails.map((e) => e?.id).toList().length,
                            itemBuilder: (context, index){
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: ProductListTile(
                                  title:  productDetails[index]?.title ?? 'NA', 
                                  description: productDetails[index]?.description ?? 'NA', 
                                  imagePath: productDetails[index]?.image ?? 'NA', 
                                  onTap: () {
                                    productVM.getRating(productDetails[index]?.id.toString() ?? '');
                                    
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetailsPage(
                                          id: productDetails[index]?.id.toString() ?? '',
                                          title: productDetails[index]?.title ?? 'NA', 
                                          description: productDetails[index]?.description ?? 'NA', 
                                          price: '${productDetails[index]?.price ?? 'NA'}', 
                                          imagePath: productDetails[index]?.image ?? 'NA',
                                        ),
                                      ),
                                    );
                                  },
                                  price: '${productDetails[index]?.price ?? 'NA'}',
                                )
                              );
                            }),
                        );
                      }
                    );
                  }
                }
              ),
            ),
          ],
        ),
      )
    );
  }
}

void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.lightGrey,
          title: const Text(TextConstants.logOut),
          content: const Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              child: const Text(TextConstants.cancel,style: TextStyle(color: AppColor.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(TextConstants.logOut,style: TextStyle(color: AppColor.red)),
              onPressed: () async {
                AuthMethod().signOut().then((value) => 
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                 )
                );
              },
            ),
          ],
        );
      },
    );
  }