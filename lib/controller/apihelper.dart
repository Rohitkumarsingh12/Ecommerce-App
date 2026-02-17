

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modal/productmodal.dart';


// ApiHelper class API call ka kaam handle karti hai
class ApiHelper {

  // Ye method API se products fetch karta hai aur ProductModel ki list return karta hai
  Future<List<ProductModel>> fetchProducts() async {

    // API ka URL define kiya gaya hai
    final url = Uri.parse("https://fakestoreapi.com/products");

    // HTTP GET request bhejna
    final response = await http.get(url);

    // Agar response success (status code 200) aata hai
    if (response.statusCode == 200) {

      // JSON string ko decode karke List me convert karna
      final List decoded = json.decode(response.body);

      // Har JSON object ko ProductModel me convert karke list return karna
      return decoded.map((e) => ProductModel.fromJson(e)).toList();

    } else {

      // Agar API call fail ho jaye to exception throw hoga
      throw Exception("Failed to fetch products");
    }
  }
}