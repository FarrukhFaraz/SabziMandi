class ProductModel {
  int? id;
  String? categoryId;
  String? subcategoryId;
  String? image;
  String? name;
  String? unit;
  String? createdAt;
  String? updatedAt;
  String? lang;
  String? nameEn;
  String? nameUr;
  String? nameAr;
  String? namePs;
  Category? category;
  Subcategory? subcategory;
  List<ProductPacking>? productPacking;
  bool addedProduct = false;
  int quantity=1;
  bool inCity = false;
  bool outCity = false;

  ProductModel(
      {this.id,
        this.categoryId,
        this.subcategoryId,
        this.image,
        this.name,
        this.unit,
        this.createdAt,
        this.updatedAt,
        this.lang,
        this.nameEn,
        this.nameUr,
        this.nameAr,
        this.namePs,
        this.category,
        this.subcategory,
        this.productPacking});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['Category_id'];
    subcategoryId = json['Subcategory_id'];
    image = json['image'];
    name = json['name'];
    unit = json['unit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lang = json['lang'];
    nameEn = json['name_en'];
    nameUr = json['name_ur'];
    nameAr = json['name_ar'];
    namePs = json['name_ps'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    subcategory = json['subcategory'] != null
        ? new Subcategory.fromJson(json['subcategory'])
        : null;
    if (json['product_packing'] != null) {
      productPacking = <ProductPacking>[];
      json['product_packing'].forEach((v) {
        productPacking!.add(new ProductPacking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Category_id'] = this.categoryId;
    data['Subcategory_id'] = this.subcategoryId;
    data['image'] = this.image;
    data['name'] = this.name;
    data['unit'] = this.unit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['lang'] = this.lang;
    data['name_en'] = this.nameEn;
    data['name_ur'] = this.nameUr;
    data['name_ar'] = this.nameAr;
    data['name_ps'] = this.namePs;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory!.toJson();
    }
    if (this.productPacking != null) {
      data['product_packing'] =
          this.productPacking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? image;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? lang;
  String? nameEn;
  String? nameUr;
  String? nameAr;
  String? namePs;

  Category(
      {this.id,
        this.image,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.lang,
        this.nameEn,
        this.nameUr,
        this.nameAr,
        this.namePs});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lang = json['lang'];
    nameEn = json['name_en'];
    nameUr = json['name_ur'];
    nameAr = json['name_ar'];
    namePs = json['name_ps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['lang'] = this.lang;
    data['name_en'] = this.nameEn;
    data['name_ur'] = this.nameUr;
    data['name_ar'] = this.nameAr;
    data['name_ps'] = this.namePs;
    return data;
  }
}

class Subcategory {
  int? id;
  String? categoryId;
  String? image;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? lang;
  String? nameEn;
  String? nameUr;
  String? nameAr;
  String? namePs;

  Subcategory(
      {this.id,
        this.categoryId,
        this.image,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.lang,
        this.nameEn,
        this.nameUr,
        this.nameAr,
        this.namePs});

  Subcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['Category_id'];
    image = json['image'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lang = json['lang'];
    nameEn = json['name_en'];
    nameUr = json['name_ur'];
    nameAr = json['name_ar'];
    namePs = json['name_ps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Category_id'] = this.categoryId;
    data['image'] = this.image;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['lang'] = this.lang;
    data['name_en'] = this.nameEn;
    data['name_ur'] = this.nameUr;
    data['name_ar'] = this.nameAr;
    data['name_ps'] = this.namePs;
    return data;
  }
}

class ProductPacking {
  int? id;
  String? productId;
  String? packingId;
  String? createdAt;
  String? updatedAt;
  Packing? packing;
  List<UnitWeight>? unitWeight;

  ProductPacking(
      {this.id,
        this.productId,
        this.packingId,
        this.createdAt,
        this.updatedAt,
        this.packing,
        this.unitWeight});

  ProductPacking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    packingId = json['packing_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    packing =
    json['packing'] != null ? new Packing.fromJson(json['packing']) : null;
    if (json['unit_weight'] != null) {
      unitWeight = <UnitWeight>[];
      json['unit_weight'].forEach((v) {
        unitWeight!.add(new UnitWeight.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['packing_id'] = this.packingId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.packing != null) {
      data['packing'] = this.packing!.toJson();
    }
    if (this.unitWeight != null) {
      data['unit_weight'] = this.unitWeight!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Packing {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? lang;
  String? nameEn;
  String? nameUr;
  String? nameAr;
  String? namePs;
  List<Units>? units;

  Packing(
      {this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.lang,
        this.nameEn,
        this.nameUr,
        this.nameAr,
        this.namePs,
        this.units});

  Packing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lang = json['lang'];
    nameEn = json['name_en'];
    nameUr = json['name_ur'];
    nameAr = json['name_ar'];
    namePs = json['name_ps'];
    if (json['units'] != null) {
      units = <Units>[];
      json['units'].forEach((v) {
        units!.add(new Units.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['lang'] = this.lang;
    data['name_en'] = this.nameEn;
    data['name_ur'] = this.nameUr;
    data['name_ar'] = this.nameAr;
    data['name_ps'] = this.namePs;
    if (this.units != null) {
      data['units'] = this.units!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Units {
  int? id;
  String? pack;
  String? unit;
  String? createdAt;
  String? updatedAt;
  String? lang;
  String? nameEn;
  String? nameUr;
  String? nameAr;
  String? namePs;

  Units(
      {this.id,
        this.pack,
        this.unit,
        this.createdAt,
        this.updatedAt,
        this.lang,
        this.nameEn,
        this.nameUr,
        this.nameAr,
        this.namePs});

  Units.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pack = json['pack'];
    unit = json['unit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lang = json['lang'];
    nameEn = json['name_en'];
    nameUr = json['name_ur'];
    nameAr = json['name_ar'];
    namePs = json['name_ps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pack'] = this.pack;
    data['unit'] = this.unit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['lang'] = this.lang;
    data['name_en'] = this.nameEn;
    data['name_ur'] = this.nameUr;
    data['name_ar'] = this.nameAr;
    data['name_ps'] = this.namePs;
    return data;
  }
}

class UnitWeight {
  int? id;
  String? packingId;
  String? unitId;
  String? weightOne;
  String? weightTwo;
  String? createdAt;
  String? updatedAt;
  Units? units;

  UnitWeight(
      {this.id,
        this.packingId,
        this.unitId,
        this.weightOne,
        this.weightTwo,
        this.createdAt,
        this.updatedAt,
        this.units});

  UnitWeight.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packingId = json['packing_id'];
    unitId = json['unit_id'];
    weightOne = json['weight_one'];
    weightTwo = json['weight_two'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    units = json['units'] != null ? new Units.fromJson(json['units']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['packing_id'] = this.packingId;
    data['unit_id'] = this.unitId;
    data['weight_one'] = this.weightOne;
    data['weight_two'] = this.weightTwo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.units != null) {
      data['units'] = this.units!.toJson();
    }
    return data;
  }
}