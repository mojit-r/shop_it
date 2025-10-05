import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_it/theme/theme.dart';

import '../data/product_data.dart';
import '/custom_ui/product_card.dart';
import '/model/product.dart';
import '/provider/data_provider.dart';
import '/screens/shopping_cart_screen.dart';

// AddProductScreen Class
class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

// AddProductScreen State Class
class _AddProductScreenState extends State<AddProductScreen> {
  // Products shuffled list
  final List<Product> productsList = List.generate(
    productTitle.length,
    (i) => Product(
      productTitle[i],
      productDescription[i],
      productImage[i],
      productPrice[i],
    ),
  )..shuffle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: const Text('Shop It'),
        centerTitle: true,
        leading: const Icon(Icons.home),
        elevation: 5,
        actions: [
          // Theme Button
          IconButton(
            onPressed: context.read<ThemeProvider>().themeChanger,

            tooltip: 'theme mode',
            icon: Selector<ThemeProvider, IconData>(
              selector: (context, provider) => provider.themeIcon,
              builder: (context, themeIcon, _) => Icon(themeIcon),
            ),
          ),

          // Shopping Cart Button
          Selector<DataProvider, int>(
            selector: (_, provider) => provider.itemCount,
            builder:
                (context, itemCount, child) => Badge.count(
                  count: itemCount,
                  textStyle: const TextStyle(fontSize: 12),
                  isLabelVisible: itemCount > 0,
                  alignment: const Alignment(0.5, -0.7),
                  child: child,
                ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShoppingCartScreen(),
                  ),
                );
              },
              tooltip: 'shopping card',
              icon: const Icon(Icons.shopping_cart_rounded),
            ),
          ),
        ],
      ),

      // Products list
      body: ListView.builder(
        itemCount: productsList.length,
        itemBuilder:
            (context, index) => ProductCard(
              product: productsList[index],
              cardType: ProductCardType.withDescription,
            ),
      ),

      // Floating Action Button
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          // floating Action Button
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShoppingCartScreen(),
                ),
              );
            },
            label: const Text('Open Cart'),
            icon: const Icon(Icons.shopping_cart_rounded),
            shape: const StadiumBorder(),
          ),

          // Cart Count Indicator
          Positioned(
            right: -5,
            top: -5,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder:
                  (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
              // the red dot counter
              child: Consumer<DataProvider>(
                builder:
                    (context, value, child) =>
                        value.itemCount > 0
                            ? Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${value.itemCount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                            : const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),

      // Floating Action Button Location
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
