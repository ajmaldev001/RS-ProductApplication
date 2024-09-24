import 'package:flutter/material.dart';
import 'package:rs_productapp_project/configs/consts/image_contants.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    super.key, 
    required this.title, 
    required this.description, 
    required this.imagePath, 
    required this.onTap, 
    required this.price
  });

  final String title;
  final String description;
  final String imagePath;
  final String price;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
return ListTile(
        title: Text(title,maxLines: 1),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                '\$$price',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        leading: AspectRatio(
          aspectRatio: 1.1,
          child: 
          imagePath.isEmpty || imagePath == 'NA'
          ? Image.asset(
            ImageConstants.emptyBoxImg,
            fit: BoxFit.contain,
            )
          : Image.network(
            imagePath,
            fit: BoxFit.contain,
            ),
          ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        selectedColor: Colors.blue,
        onTap: onTap,
        tileColor: Colors.grey[200],
      );
  }
}