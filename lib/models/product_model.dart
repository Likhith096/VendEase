class Product {
  final String id;
  final String category;
  final String name;
  final double price;
  final double weight;
  final String imageURL;

  Product({
    required this.id,
    required this.category,
    required this.name,
    required this.price,
    required this.weight,
    required this.imageURL, // Add this line
  });
}
