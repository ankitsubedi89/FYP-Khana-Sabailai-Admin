class AllRestaurants {
  bool? success;
  String? message;
  List<Restaurant>? restaurant;

  AllRestaurants({this.success, this.message, this.restaurant});

  AllRestaurants.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      restaurant = <Restaurant>[];
      json['data'].forEach((v) {
        restaurant!.add(Restaurant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (restaurant != null) {
      data['data'] = restaurant!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurant {
  String? id;
  String? name;
  String? contact;
  String? address;
  String? lat;
  String? lon;
  String? email;
  String? password;
  String? image;
  String? isDeleted;

  Restaurant(
      {this.id,
      this.name,
      this.contact,
      this.address,
      this.lat,
      this.lon,
      this.email,
      this.password,
      this.image,
      this.isDeleted});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
    address = json['address'];
    lat = json['lat'];
    lon = json['lon'];
    email = json['email'];
    password = json['password'];
    image = json['image'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['contact'] = contact;
    data['address'] = address;
    data['lat'] = lat;
    data['lon'] = lon;
    data['email'] = email;
    data['password'] = password;
    data['image'] = image;
    data['is_deleted'] = isDeleted;
    return data;
  }
}
