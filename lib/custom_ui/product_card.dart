import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_it/provider/data_provider.dart';
import '/model/product.dart';

// a Size datatype variable
late Size mq;

// enum for ProductCardTypes
enum ProductCardType { withDescription, withPrice }

// ProductCard Class
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.cardType});

  final Product product;
  final ProductCardType cardType;

  @override
  Widget build(BuildContext context) {
    // Media Query Instiation
    mq = MediaQuery.of(context).size;

    // Card
    return Selector<DataProvider, bool>(
      selector: (context, provider) => provider.isInCart(product),
      builder:
          (context, isInCart, _) => Card(
            color: isInCart ? const Color.fromARGB(255, 232, 255, 233) : null,
            elevation: 4,
            margin: EdgeInsets.symmetric(
              horizontal: mq.width * 0.015,
              vertical: mq.height * 0.012,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),

            // card data
            child: Padding(
              padding: EdgeInsets.only(right: mq.width * 0.01),
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(
                  mq.width * 0.03,
                  mq.height * 0.01,
                  mq.width * 0.001,
                  mq.height * 0.01,
                ),

                // product image
                leading: Image.asset(product.image),

                // product titile
                title: Text(
                  product.title,
                  style:
                      isInCart ? Theme.of(context).textTheme.bodyLarge : null,
                ),

                // product description or price
                subtitle: Text(
                  cardType == ProductCardType.withDescription
                      ? product.description
                      : '₹ ${product.price}',
                  style:
                      isInCart ? Theme.of(context).textTheme.bodyMedium : null,
                ),

                // add to cart button
                trailing:
                    isInCart
                        // added button
                        ? IconButton(
                          onPressed: () {
                            context.read<DataProvider>().removeItem(product);
                          },
                          icon: Image.asset('assets/images/checkmark.png'),
                        )
                        // add button
                        : ElevatedButton.icon(
                          onPressed: () {
                            context.read<DataProvider>().addItem(product);

                            // snackBar on iten add
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Item Added to the Cart',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add_shopping_cart_outlined),
                          label: const Text('Add'),
                        ),
              ),
            ),
          ),
    );
  }
}
