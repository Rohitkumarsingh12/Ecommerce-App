

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modal/productmodal.dart';
import '../controller/cartprovider.dart';
import 'cartscreen.dart';

// Ye ProductDetailScreen widget hai jo kisi ek product ki details show karta hai
class ProductDetailScreen extends StatelessWidget {

  // Jo product select hua hai uska data yaha receive hota hai
  final ProductModel product;

  // Constructor jisme product pass kiya jata hai
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {

    // CartProvider ka object lena taaki cart me product add kiya ja sake
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(

      // Screen ka background color
      backgroundColor: Colors.grey.shade100,

      // Top AppBar
      appBar: AppBar(
        title: const Text("Product Details"), // AppBar title
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),

      // Body me pura content scrollable banaya gaya hai
      body: SingleChildScrollView(
        child: Column(
          children: [

            // 🔥 Product Image Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              // White background aur bottom rounded corner
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),

              // Product image ko rounded shape me show karna
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  product.image, // Product image URL
                  height: 260,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Product information section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // 🔹 Product Title
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 🔹 Rating Row
                  Row(
                    children: [
                      const Icon(Icons.star,
                          color: Colors.orange, size: 20),
                      const SizedBox(width: 4),

                      // Product rating show karna
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // 🔹 Product Price
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔹 Description Card
                  Container(
                    padding: const EdgeInsets.all(16),

                    // Card style decoration
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),

                    // Product description
                    child: Text(
                      product.description,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),

      // 🔥 Bottom me Add to Cart button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),

        child: SizedBox(
          width: double.infinity,
          height: 55,

          child: ElevatedButton(

            // Button style
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),

            // Button press hone par action
            onPressed: () {

              // Check karta hai product already cart me hai ya nahi
              bool alreadyAdded = cartProvider.cartItems
                  .any((item) => item.product.id == product.id);

              if (alreadyAdded) {

                // Agar product already cart me hai to snackbar show karega
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Product already added!"),
                    duration: Duration(seconds: 2),
                  ),
                );

              } else {

                // Agar product cart me nahi hai to add kar diya jayega
                cartProvider.addToCart(product);

                // Cart screen par navigate karega
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const CartScreen()),
                );
              }
            },

            // Button text
            child: const Text(
              "Add to Cart",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}