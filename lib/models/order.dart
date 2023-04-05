class AllOrders {
  bool? success;
  String? message;
  List<Order>? order;

  AllOrders({this.success, this.message, this.order});

  AllOrders.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      order = <Order>[];
      json['data'].forEach((v) {
        order!.add(Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (order != null) {
      data['data'] = order!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  String? id;
  String? date;
  String? totalCost;
  String? specialRequest;
  String? restaurantId;
  String? status;
  String? isPaid;
  String? userId;
  String? restaurantName;
  String? restaurantContact;
  String? restaurantAddress;
  List<OrderLines>? orderLines;

  Order(
      {this.id,
      this.date,
      this.totalCost,
      this.specialRequest,
      this.restaurantId,
      this.status,
      this.isPaid,
      this.userId,
      this.restaurantName,
      this.restaurantContact,
      this.restaurantAddress,
      this.orderLines});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    totalCost = json['total_cost'];
    specialRequest = json['special_request'];
    restaurantId = json['restaurant_id'];
    status = json['status'];
    isPaid = json['is_paid'];
    userId = json['user_id'];
    restaurantName = json['restaurant_name'];
    restaurantContact = json['restaurant_contact'];
    restaurantAddress = json['restaurant_address'];
    if (json['order_lines'] != null) {
      orderLines = <OrderLines>[];
      json['order_lines'].forEach((v) {
        orderLines!.add(OrderLines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['total_cost'] = totalCost;
    data['special_request'] = specialRequest;
    data['restaurant_id'] = restaurantId;
    data['status'] = status;
    data['is_paid'] = isPaid;
    data['user_id'] = userId;
    data['restaurant_name'] = restaurantName;
    data['restaurant_contact'] = restaurantContact;
    data['restaurant_address'] = restaurantAddress;
    if (orderLines != null) {
      data['order_lines'] = orderLines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderLines {
  String? orderDetailId;
  String? menuId;
  String? food;
  String? price;
  String? image;
  String? description;
  String? catId;
  String? catName;
  String? quantity;
  String? lineTotal;

  OrderLines(
      {this.orderDetailId,
      this.menuId,
      this.food,
      this.price,
      this.image,
      this.description,
      this.catId,
      this.catName,
      this.quantity,
      this.lineTotal});

  OrderLines.fromJson(Map<String, dynamic> json) {
    orderDetailId = json['order_detail_id'];
    menuId = json['menu_id'];
    food = json['food'];
    price = json['price'];
    image = json['image'];
    description = json['description'];
    catId = json['cat_id'];
    catName = json['cat_name'];
    quantity = json['quantity'];
    lineTotal = json['line_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_detail_id'] = orderDetailId;
    data['menu_id'] = menuId;
    data['food'] = food;
    data['price'] = price;
    data['image'] = image;
    data['description'] = description;
    data['cat_id'] = catId;
    data['cat_name'] = catName;
    data['quantity'] = quantity;
    data['line_total'] = lineTotal;
    return data;
  }
}
