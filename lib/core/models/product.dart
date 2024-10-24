// ignore_for_file: non_constant_identifier_names

class Product{
  int id;
  String nama_product, deskripsi, image, link, categori;

  Product({
    required this.id, 
    required this.nama_product, 
    required this.categori, 
    required this.deskripsi, 
    required this.image,
    required this.link,
  });

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json['id'],
      nama_product: json['nama_product'],
      categori: json['categori'],
      deskripsi: json['deskripsi'],
      image: json['image'],
      link: json['link'],
    );
  }
}