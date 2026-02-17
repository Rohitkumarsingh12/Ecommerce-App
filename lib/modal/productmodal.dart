// ProductModel ek data model class hai jo API se aane wale product data ko store karne ke liye use hoti hai
class ProductModel {

  // Product ka unique id store karta hai
  final int id;

  // Product ka title / name store karta hai
  final String title;

  // Product ki price store karta hai
  final double price;

  // Product ka description store karta hai
  final String description;

  // Product ki image ka URL store karta hai
  final String image;

  // Product ki rating store karta hai
  final double rating;

  // Constructor jo object banate waqt sari values receive karta hai
  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.rating,
  });

  // Factory constructor jo JSON data ko ProductModel object me convert karta hai
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(

      // JSON se id lekar id variable me store karta hai
      id: json['id'],

      // JSON se title lekar title variable me store karta hai
      title: json['title'],

      // JSON se price lekar usko double type me convert karta hai
      price: json['price'].toDouble(),

      // JSON se description lekar description variable me store karta hai
      description: json['description'],

      // JSON se image URL lekar image variable me store karta hai
      image: json['image'],

      // JSON ke andar rating object se rate value lekar usko double me convert karta hai
      rating: (json['rating']?['rate'] ?? 0).toDouble(),
    );
  }
}