class Product {
  final String productImageUrl;
  final String productName;
  final String productDescription;

  Product(
      {required this.productDescription,
      required this.productImageUrl,
      required this.productName});

 static List<Product> products = [
    Product(
        productDescription: 'jacket',
        productImageUrl:
            'https://filson-canto.imgix.net/sfi96vqojp2kf0cc843vdqhh0s/473jyYlXduHPdRoGSzAvpZdHeLQ/original?h=800&w=800&bg=0FFF&q=80&auto=format,compress&fit=fillmax',
        productName: 'Jacket'),
    Product(
        productDescription: 'tshirt',
        productImageUrl:
            'https://www.backcountry.com/images/items/large/FSN/FSN0058/BK.jpg',
        productName: 'T-shirt'),
    Product(
        productDescription: 'pant',
        productImageUrl:
            'https://www.beaubags.com/media/catalog/product/cache/3/image/0dc2d03fe217f8c83829496872af24a0/f/i/filson-tin-cloth-short-lined-cruiser-black-front.jpg',
        productName: 'pant'),
    Product(
        productDescription: 'joggers',
        productImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRi33kxa6WQ3g94bxPrIs_oCRWQ-fCpdPejIkRFc-iryQ8JzHkhPoW-__gOGkMwcfdVALc&usqp=CAU',
        productName: 'joggers'),
    Product(
        productDescription: 'vest',
        productImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_bx6K-948sY3zl0Wa8BupQw5u8huj4ZTz082MGaNKXQVDwEqeH-BjpFJCAJmlzox3xzo&usqp=CAU',
        productName: 'vest'),
    Product(
        productDescription: 'sweater',
        productImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEktpWHqEk1HaxWg5P1Xr00hCjF_TF7vi38df01n9GfY_fnosqFI4sDVl_7UymcyEjZYs&usqp=CAU',
        productName: 'sweater'),
  ];

}
