import 'package:haweyati/models/options_model.dart';
import 'package:haweyati/models/suppliers_model.dart';
import 'package:hive/hive.dart';
import 'images_model.dart';

part 'finishing-product.g.dart';

@HiveType(typeId: 16)
class FinProduct extends HiveObject{
  @HiveField(0)
  List<Supplier> suppliers;
  @HiveField(1)
  String sId;
  @HiveField(2)
  double price;
  @HiveField(3)
  String name;
  @HiveField(4)
  String description;
  @HiveField(5)
  String parent;
  @HiveField(6)
  List<ProductOption> options;
  @HiveField(7)
  List<Map<String,dynamic>> variants;
  @HiveField(8)
  Images images;
  @HiveField(9)
  int iV;

  FinProduct(
      {this.suppliers,
        this.sId,
        this.price,
        this.name,
        this.variants,
        this.parent,
        this.description,
        this.options,
        this.images,
        this.iV});

  FinProduct.fromJson(Map<String, dynamic> json) {
//    print(json);
    sId = json['_id'];
    name = json['name'];
    price = double.parse(json['price'].toString());
    description = json['description'];
    parent = json['parent'];
    if (json['options'] != null) {
      options = List<ProductOption>();
      json['options'].forEach((v) {
        options.add( ProductOption.fromJson(v));
      });
    }
    if (json['suppliers'] != null) {
      suppliers = List<Supplier>();
      json['suppliers'].forEach((v) {
        suppliers.add( Supplier.fromJson(v));
      });
    }
    variants = json['varient'].cast<Map<String,dynamic>>();
//    if (json['varient'] != null) {
//      variants = List<Variant>();
//      json['varient'].forEach((v) {
//        variants.add( Variant.fromJson(v));
//      });
//    }
    if (json['image'] != null) {
      images = Images.fromJson(json['image']);
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['suppliers'] = this.suppliers;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['parent'] = this.parent;
    data['varient'] = this.variants;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    if (this.suppliers != null) {
      data['suppliers'] = this.suppliers.map((v) => v.toJson()).toList();
    }
//    if (this.variants != null) {
//      data['varient'] = this.options.map((v) => v.toJson()).toList();
//    }
    if (this.images != null) {
      data['image'] = this.images.toJson();
    }
    data['__v'] = this.iV;
    return data;
  }
}


