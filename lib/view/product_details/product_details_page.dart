import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_productapp_project/configs/colors/app_colors.dart';
import 'package:rs_productapp_project/configs/consts/image_contants.dart';
import 'package:rs_productapp_project/view_model/product_details_view_model.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key,
  required this.title, 
  required this.description, 
  required this.price, 
  required this.imagePath, required this.id});
  
  final String id;
  final String title;
  final String description;
  final String price;
  final String imagePath;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: AppColor.lightGrey?.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(24)
                  ),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColor.lightGrey?.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(context.select<ProductDetailsViewModel,String>((value) => value.ratingStar.toString()),
                        style: const TextStyle(fontSize: 18),),
                        const Icon(Icons.star, size: 18,color: Colors.amberAccent,),
                        const SizedBox(width: 4),
                        Text('(${context.select<ProductDetailsViewModel,String>((value) => value.ratingCount.toString())})',
                        style: const TextStyle(color: AppColor.black,fontSize: 16),)
                      ],
                    ),
                  ),
                )
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.white,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8.0),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(widget.title,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),maxLines: 2)),
                        Expanded(
                          flex: 1,
                          child: Text('\$${widget.price}',style: const TextStyle(fontSize: 16),textAlign: TextAlign.end,)),
                      ],
                    ),
                  ),

                ],
              )
            ),
            expandedHeight: 350,
            flexibleSpace: FlexibleSpaceBar(
              background: 
              widget.imagePath.isNotEmpty || widget.imagePath != 'NA'
              ? Image.network(
                widget.imagePath,
                fit: BoxFit.contain,
              )
              : Image.asset(
                ImageConstants.emptyBoxImg,
                 width: double.maxFinite,
                 fit: BoxFit.cover,
                ),
            ),
          ),
           SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16,8,16,32),
              child: Text(widget.description,
              style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: context.select<ProductDetailsViewModel,bool>((value) => value.isInCart(widget.id)) 
        ? AppColor.blue : AppColor.white, 
        icon: const Icon(Icons.add_shopping_cart,size: 20),
        onPressed: (){
          context.read<ProductDetailsViewModel>().addCartCount(widget.id);
        }, 
        label: Text(
          context.select<ProductDetailsViewModel,bool>((value) => value.isInCart(widget.id))
          ? 'Remove from Cart' : 'Add to Cart')
        ),
    );
  }
}