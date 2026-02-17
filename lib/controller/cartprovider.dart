
import 'package:flutter/foundation.dart';
import '../modal/productmodal.dart';

// Ye class ek cart item ko represent karti hai jisme product aur uski quantity store hoti hai
class CartItem {

  // Cart me jo product add hua hai uska data
  final ProductModel product;

  // Product ki quantity (default 1 hoti hai)
  int quantity;

  // Constructor jo product aur quantity receive karta hai
  CartItem({required this.product, this.quantity = 1});
}


// Ye provider class cart ka pura state manage karti hai
// ChangeNotifier use kiya gaya hai taaki jab cart data change ho to UI automatically update ho jaye
class CartProvider with ChangeNotifier {

  // Cart ke sare items ko store karne wali list
  final List<CartItem> _cartItems = [];

  // Getter jisse UI cart items ko access kar sakta hai
  List<CartItem> get cartItems => _cartItems;


  // Ye method ProductList ya ProductDetail screen se product ko cart me add karta hai
  void addToCart(ProductModel product) {

    // Check karta hai ki product pehle se cart me hai ya nahi
    final index = _cartItems.indexWhere((item) => item.product.id == product.id);

    // Agar product cart me already hai to uski quantity increase ho jayegi
    if (index >= 0) {
      _cartItems[index].quantity += 1;

    } else {

      // Agar product cart me nahi hai to naya CartItem add hoga
      _cartItems.add(CartItem(product: product));
    }

    // UI ko update karne ke liye notify kiya jata hai
    notifyListeners();
  }


  // Ye method cart se kisi product ko remove karta hai
  void removeFromCart(ProductModel product) {

    // Product id match karke usko cart list se remove kar deta hai
    _cartItems.removeWhere((item) => item.product.id == product.id);

    // UI update ke liye notify
    notifyListeners();
  }


  // Ye method CartScreen me product ki quantity increase karta hai
  void incrementQuantity(ProductModel product) {

    // Product ko cart me search karta hai
    final index = _cartItems.indexWhere((item) => item.product.id == product.id);

    // Agar product mil jaye to quantity increase ho jayegi
    if (index >= 0) {
      _cartItems[index].quantity += 1;

      // UI update
      notifyListeners();
    }
  }


  // Ye method CartScreen me product ki quantity decrease karta hai
  void decrementQuantity(ProductModel product) {

    // Product ko cart me search karta hai
    final index = _cartItems.indexWhere((item) => item.product.id == product.id);

    // Agar quantity 1 se jyada hai to hi decrease hogi
    if (index >= 0 && _cartItems[index].quantity > 1) {
      _cartItems[index].quantity -= 1;

      // UI update
      notifyListeners();
    }
  }


  // Ye getter cart ka total price calculate karta hai
  double get totalPrice {

    double total = 0;

    // Har item ka price * quantity karke total me add karta hai
    for (var item in _cartItems) {
      total += item.product.price * item.quantity;
    }

    return total;
  }


  // Ye getter cart me total items (quantity ka sum) calculate karta hai
  int get totalItems {

    int sum = 0;

    // Har item ki quantity ko add karke total count nikalta hai
    for (var item in _cartItems) {
      sum += item.quantity;
    }

    return sum;
  }
}