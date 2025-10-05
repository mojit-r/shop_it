class Product {
  final String title;
  final String description;
  final String image;
  final int price;

  // Class contructor with both disctiption and price
  Product(this.title, this.description, this.image, this.price);

  // Class constructor with discription
  Product.withDescription(this.title, this.description, this.image) : price = 0;

  // Class costructor with price
  Product.withPrice(this.title, this.price, this.image) : description = '';

  // Convert Product -> Map (for Json)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'price': price,
    };
  }

  // Convert Map -> Product (from Json)
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      map['title'] ?? '',
      map['description'] ?? '',
      map['image'] ?? '',
      map['price'] ?? 0,
    );
  }

  // for equallity check
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          other.runtimeType == runtimeType &&
          other.title == title &&
          other.price == price &&
          other.image == image;

  @override
  int get hashCode => Object.hash(title, price, image);  
}
