class AllMenus {
  bool? success;
  List<String>? message;
  List<Menu>? menu;

  AllMenus({this.success, this.message, this.menu});

  AllMenus.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'].cast<String>();
    if (json['data'] != null) {
      menu = <Menu>[];
      json['data'].forEach((v) {
        menu!.add(Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (menu != null) {
      data['data'] = menu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menu {
  String? id;
  String? food;
  String? categoryId;
  String? price;
  String? quantity;
  String? image;
  String? restaurantId;
  String? date;
  String? description;
  String? isDeleted;

  Menu(
      {this.id,
      this.food,
      this.categoryId,
      this.price,
      this.quantity,
      this.image,
      this.restaurantId,
      this.date,
      this.description,
      this.isDeleted});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    food = json['food'];
    categoryId = json['category_id'];
    price = json['price'];
    quantity = json['quantity'];
    image = json['image'];
    restaurantId = json['restaurant_id'];
    date = json['date'];
    description = json['description'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['food'] = food;
    data['category_id'] = categoryId;
    data['price'] = price;
    data['quantity'] = quantity;
    data['image'] = image;
    data['restaurant_id'] = restaurantId;
    data['date'] = date;
    data['description'] = description;
    data['is_deleted'] = isDeleted;
    return data;
  }
}
