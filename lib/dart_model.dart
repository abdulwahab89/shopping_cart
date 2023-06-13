class Cart {
  late final int? id;
  late final String? productId;
  late final String? productName;
  late final int? initialPrice;
  late final int? productPrice;
  late final int? quantity;
  late final String? unitTag;
  late final String? image;
  Cart({
    required this.id,
    required this.productPrice,
    required this.image,
    required this.initialPrice,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitTag,
  });
  Cart.fromMap(Map<dynamic, dynamic> res)
      : id = res['id'],
        productId = res['productId'],
        productName = res['productName'],
        productPrice = res['productPrice'],
        initialPrice = res['initialPrice'],
        quantity = res['quantity'],
        unitTag = res['unitTag'],
        image = res['image'];
  Map<String, Object?> toMap() {
    return {
      'productName': productName,
      'id': id,
      'productId': productId,
      'initialPrice': initialPrice,
      'productPrice': productPrice,
      'quantity': quantity,
      'unitTag': unitTag,
      'image': image,
    };
  }
}
