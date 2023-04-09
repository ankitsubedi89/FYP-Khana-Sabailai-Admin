class AllLOC {
  bool? success;
  List<String>? message;
  List<Loc>? data;

  AllLOC({this.success, this.message, this.data});

  AllLOC.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'].cast<String>();
    if (json['data'] != null) {
      data = <Loc>[];
      json['data'].forEach((v) {
        data!.add(new Loc.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Loc {
  String? id;
  String? name;
  String? email;
  String? contact;

  Loc({this.id, this.name, this.email, this.contact});

  Loc.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact'] = this.contact;
    return data;
  }
}
