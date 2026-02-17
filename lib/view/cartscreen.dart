import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/cartprovider.dart';

// Ye CartScreen widget hai jo cart ke items display karta hai
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Consumer use kiya gaya hai taaki CartProvider ke data me change hote hi UI update ho jaye
    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) {

        // Cart me jo items hain unko list me store kiya gaya hai
        final cartItems = cartProvider.cartItems;

        // Cart me distinct products ka count
        int distinctItemsCount = cartItems.length;

        return Scaffold(

          // Top AppBar
          appBar: AppBar(
            title: const Text("Cart"),
            backgroundColor: Colors.blue,

            // AppBar ke right side cart item count badge
            actions: [
              if (distinctItemsCount > 0)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),

                      // Cart item count show karna
                      child: Text(
                        distinctItemsCount.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // Body section
          body: cartItems.isEmpty

          // Agar cart empty hai to message show karega
              ? const Center(
            child: Text(
              "Your cart is empty",
              style: TextStyle(fontSize: 18),
            ),
          )

          // Agar cart me items hain to unko list me show karega
              : Column(
            children: [

              // Product list
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,

                  itemBuilder: (context, index) {

                    // Current cart item
                    final cartItem = cartItems[index];

                    // Product data
                    final product = cartItem.product;

                    // Total price = price * quantity
                    final totalPrice =
                        product.price * cartItem.quantity;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),

                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(12),

                          child: Row(
                            children: [

                              // Product image
                              Image.network(
                                product.image,
                                height: 80,
                                width: 80,
                              ),

                              const SizedBox(width: 12),

                              // Product details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    // Product title
                                    Text(
                                      product.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),

                                    const SizedBox(height: 4),

                                    // Product total price
                                    Text(
                                      "Price: \$${totalPrice.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),

                                    const SizedBox(height: 8),

                                    // Product rating
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.orange,
                                            size: 16),
                                        const SizedBox(width: 4),
                                        Text(product.rating.toString()),
                                      ],
                                    ),

                                    const SizedBox(height: 8),

                                    // Quantity control row
                                    Row(
                                      children: [

                                        // Quantity decrease button
                                        IconButton(
                                          icon:
                                          const Icon(Icons.remove),
                                          onPressed: () {
                                            cartProvider
                                                .decrementQuantity(
                                                product);
                                          },
                                        ),

                                        // Current quantity
                                        Text(cartItem.quantity.toString(),
                                            style: const TextStyle(
                                                fontSize: 16)),

                                        // Quantity increase button
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            cartProvider
                                                .incrementQuantity(
                                                product);
                                          },
                                        ),

                                        const Spacer(),

                                        // Product delete button
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () {
                                            cartProvider
                                                .removeFromCart(
                                                product);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Bottom orange container jisme total price aur Buy Now button hai
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    vertical: 16, horizontal: 16),
                color: Colors.orange,

                child: Row(
                  children: [

                    // Total price section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Price",
                            style: TextStyle(
                                fontSize: 14, color: Colors.white70),
                          ),
                          const SizedBox(height: 4),

                          // Total cart price show karna
                          Text(
                            "\$${cartProvider.totalPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Buy Now button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {

                          // Purchase successful ka dialog show karega
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title:
                              const Text("Purchase Successful!"),
                              content: Text(
                                  "Your purchase of \$${cartProvider.totalPrice.toStringAsFixed(2)} was successful."),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(),
                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                          );
                        },

                        // Button style
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),

                        // Button text
                        child: const Text(
                          "Buy Now",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}