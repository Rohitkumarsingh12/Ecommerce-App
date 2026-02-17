

import 'package:ecommerceapp/view/productdetailscreen.dart';
import 'package:ecommerceapp/view/cartscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/productprovider.dart';
import '../controller/cartprovider.dart';
import '../modal/productmodal.dart';


// Ye main ProductListScreen widget hai jo StatefulWidget hai
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}


// Ye screen ka state class hai jisme UI aur logic likha gaya hai
class _ProductListScreenState extends State<ProductListScreen> {

  // initState screen load hote hi ek baar call hota hai
  // Yaha API se products fetch kiye ja rahe hain
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }


  // Ye method UI build karta hai
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Screen ka background color
      backgroundColor: Colors.grey.shade200,

      // Top AppBar
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 1,
        centerTitle: true,

        // AppBar title
        title: const Text(
          "Product Screen",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),

        // AppBar ke right side actions
        actions: [

          // CartProvider ko listen karke cart item count show karna
          Consumer<CartProvider>(
            builder: (context, cartProvider, _) {

              // Cart me kitne items hain
              int itemCount = cartProvider.cartItems.length;

              return Stack(
                alignment: Alignment.center,
                children: [

                  // Cart icon button
                  IconButton(
                    icon: const Icon(Icons.shopping_cart, color: Colors.white),
                    onPressed: () {

                      // CartScreen par navigate
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CartScreen(),
                        ),
                      );
                    },
                  ),

                  // Agar cart me item hai to badge show hoga
                  if (itemCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),

                        // Cart item count
                        child: Text(
                          itemCount.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),

      // Body me product list show hogi
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) {

          // Agar loading chal rahi hai to progress indicator
          if (provider.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Products list provider se lena
          final products = provider.products;

          // Agar koi product nahi hai
          if (products.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          // Products ko grid me show karna
          return GridView.builder(
            padding: const EdgeInsets.all(8),

            // Total products
            itemCount: products.length,

            // Grid layout configuration
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.72,
            ),

            // Har product ka UI
            itemBuilder: (context, index) {

              // Current product
              final ProductModel product = products[index];

              return GestureDetector(

                // Product par click karne par detail screen open
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(product: product),
                    ),
                  );
                },

                // Product card
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// PRODUCT IMAGE
                      Expanded(
                        child: ClipRRect(
                          borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(8)),
                          child: Image.network(
                            product.image,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      /// PRODUCT TITLE
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        child: Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      /// PRODUCT RATING
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          children: [
                            Icon(Icons.star, size: 14, color: Colors.green),
                            SizedBox(width: 3),
                            Text(
                              "4.5",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 4),

                      /// PRODUCT PRICE
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                        child: Text(
                          "\$${product.price}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}