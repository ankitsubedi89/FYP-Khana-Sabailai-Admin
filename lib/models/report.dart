class AllReport {
  String? totalOrders;
  String? totalSales;
  List<Menu>? menu;
  List<Restaurant>? restaurant;
  bool? success;

  AllReport(
      {this.totalOrders,
      this.totalSales,
      this.menu,
      this.restaurant,
      this.success});

  AllReport.fromJson(Map<String, dynamic> json) {
    totalOrders = json['total_orders'];
    totalSales = json['total_sales'];
    if (json['menu'] != null) {
      menu = <Menu>[];
      json['menu'].forEach((v) {
        menu!.add(Menu.fromJson(v));
      });
    }
    if (json['restaurant'] != null) {
      restaurant = <Restaurant>[];
      json['restaurant'].forEach((v) {
        restaurant!.add(Restaurant.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_orders'] = totalOrders;
    data['total_sales'] = totalSales;
    if (menu != null) {
      data['menu'] = menu!.map((v) => v.toJson()).toList();
    }
    if (restaurant != null) {
      data['restaurant'] = restaurant!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }
}

class Menu {
  String? food;
  String? image;
  String? totalQuantity;
  String? totalSales;
  String? date;

  Menu({this.food, this.image, this.totalQuantity, this.totalSales, this.date});

  Menu.fromJson(Map<String, dynamic> json) {
    food = json['food'];
    image = json['image'];
    totalQuantity = json['total_quantity'];
    totalSales = json['total_sales'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['food'] = food;
    data['image'] = image;
    data['total_quantity'] = totalQuantity;
    data['total_sales'] = totalSales;
    data['date'] = date;
    return data;
  }
}

class Restaurant {
  String? name;
  String? image;
  String? totalOrders;
  String? totalSales;
  String? date;

  Restaurant(
      {this.name, this.image, this.totalOrders, this.totalSales, this.date});

  Restaurant.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    totalOrders = json['total_orders'];
    totalSales = json['total_sales'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['total_orders'] = totalOrders;
    data['total_sales'] = totalSales;
    data['date'] = date;
    return data;
  }
}
