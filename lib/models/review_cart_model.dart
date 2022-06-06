class ReviewCartModel {
  String? cartId;
  String? cartImage;
  String? cartName;
  int? cartPrice;
  int? cartQuantity;
  var cartUnit;

  ReviewCartModel({
    this.cartUnit,
    this.cartId,
    this.cartImage,
    this.cartName,
    this.cartPrice,
    this.cartQuantity,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "cartId": cartId,
      "cartImage": cartImage,
      "cartName": cartName,
      "cartPrice": cartPrice,
      "cartQuantity": cartQuantity,
      "cartUnit": cartUnit,
    };
  }
}
