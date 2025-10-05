import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/data_provider.dart';
import '/custom_ui/product_card.dart';
import '/model/product.dart';
import 'package:intl/intl.dart';

// Media Query Declaration
late Size mq;

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // media Query Initialization
    mq = MediaQuery.of(context).size;

    // Cart Provider
    final cartProvider = Provider.of<DataProvider>(context);
    final List<Product> cartItems = cartProvider.cartItems;

    // Prooduct Price Total
    final total = cartItems.fold(0, (sum, product) => sum + product.price);

    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: const Text('Shop It'),
        centerTitle: true,
        elevation: 5,
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              onPressed: () => cartProvider.clearCart(),
              icon: const Icon(Icons.delete_outline),
              tooltip: 'clear cart',
            ),
        ],
      ),

      // Products list in ShoppingCartScreen
      body:
          cartItems.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_shopping_cart,
                      size: mq.height * 0.1,
                      color: Colors.grey,
                    ),
                    SizedBox(height: mq.height * 0.01),
                    Text(
                      'Your cart is empty!',
                      style: TextStyle(
                        fontSize: mq.height * 0.025,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                itemCount: cartItems.length,
                itemBuilder:
                    (context, index) => ProductCard(
                      product: cartItems[index],
                      cardType: ProductCardType.withPrice,
                    ),
              ),

      // Floating Action Button
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          // Extended Floating Action Button
          FloatingActionButton.extended(
            onPressed:
                cartItems.isEmpty
                    ? null
                    : () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text('Total Price'),
                              content: Text(
                                NumberFormat.currency(
                                  locale: 'en_IN',
                                  symbol: '₹ ',
                                  decimalDigits: 0,
                                ).format(total),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                      );
                    },
            label: const Text('Buy Now'),
            icon: const Icon(Icons.shopping_cart_rounded),
            shape: const StadiumBorder(),
            backgroundColor:
                cartItems.isEmpty
                    ? Colors.grey.shade400
                    : Theme.of(context).colorScheme.primary,
            foregroundColor: cartItems.isEmpty ? Colors.black45 : Colors.white,
          ),

          // Cart Product Count Indicator
          Positioned(
            top: -5,
            right: -5,
            // with MaterialButton just following the video course
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
        ],
      ),

      // Floating Action Button Location
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
