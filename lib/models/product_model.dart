class ProductModel {
  String productName;
  String productImage;
  num productPrice;
  String? productId;
  int? productQuantity;
  List<dynamic>? productUnit;
  String? about;
  int? cartQuantity;
  int? soldNum;
  ProductModel({
    this.productQuantity,
    this.productId,
    this.productUnit,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.about,
    this.cartQuantity,
    this.soldNum
  });

  @override
  String toString() {
    return 'ProductModel{productName: $productName, productImage: $productImage, productPrice: $productPrice, productId: $productId, productQuantity: $productQuantity, productUnit: $productUnit, about: $about}';
  }
}
