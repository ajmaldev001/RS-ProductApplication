import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:rs_productapp_project/configs/colors/app_colors.dart';

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({super.key, required this.badgetCount, required this.size});
  final String badgetCount;
  final double size;
  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: -12, end: -8),
      badgeContent: Text(badgetCount,style: const TextStyle(fontSize: 10),),
      badgeStyle: const badges.BadgeStyle(badgeColor: AppColor.blue),
      badgeAnimation: const badges.BadgeAnimation.scale(
        animationDuration: Duration(seconds: 1),
        colorChangeAnimationDuration: Duration(seconds: 1),
        loopAnimation: false,
        curve: Curves.fastOutSlowIn,
        colorChangeAnimationCurve: Curves.easeInCubic,
      ),
      child: Icon(Icons.shopping_cart,size: size),
    );
  }
}