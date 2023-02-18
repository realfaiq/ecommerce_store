class Products {
  String? id;
  String? category;
  String? productName;
  String? productDetails;
  int? price;
  String? serialCode;
  List<String>? images;
  bool? isOnSale;
  bool? isPopular;
  bool? isFavorite;

  Products(
      {this.id,
      this.category,
      this.productName,
      this.productDetails,
      this.price,
      this.serialCode,
      this.images,
      this.isOnSale,
      this.isPopular,
      this.isFavorite});
}
