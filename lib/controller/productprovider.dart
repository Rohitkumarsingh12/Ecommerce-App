
import 'package:flutter/foundation.dart';
import '../modal/productmodal.dart';
import 'apihelper.dart';


// ProductProvider ek state management class hai jo ChangeNotifier ko use karti hai
// taaki jab data change ho to UI automatically update ho jaye
class ProductProvider with ChangeNotifier {

  // ApiHelper ka object banaya gaya hai jisse API call ki jayegi
  final ApiHelper apiHelper;

  // Ye list API se aaye hue sare products ko store karegi
  List<ProductModel> _products = [];

  // Ye variable loading state ko track karta hai (data load ho raha hai ya nahi)
  bool _loading = false;

  // Constructor jisme ApiHelper ko receive kiya jata hai
  ProductProvider({required this.apiHelper});

  // Getter method jo products list ko UI me access karne ke liye use hota hai
  List<ProductModel> get products => _products;

  // Getter method jo loading state ko UI me access karne ke liye use hota hai
  bool get loading => _loading;

  // Ye method API se product data fetch karta hai
  Future<void> fetchProducts() async {

    // Loading ko true set kiya jata hai jab data fetch hona start hota hai
    _loading = true;

    // notifyListeners UI ko batata hai ki data change ho gaya hai
    notifyListeners();

    try {

      // ApiHelper ke fetchProducts method ko call karke product data liya jata hai
      _products = await apiHelper.fetchProducts();

    } catch (e) {

      // Agar koi error aaye to debug mode me console me print ho jayega
      if (kDebugMode) print("Error fetching products: $e");

    } finally {

      // Jab API call complete ho jaye to loading ko false kar diya jata hai
      _loading = false;

      // UI ko update karne ke liye notifyListeners fir se call kiya jata hai
      notifyListeners();
    }
  }
}