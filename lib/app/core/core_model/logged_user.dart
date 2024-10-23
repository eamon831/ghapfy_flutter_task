class Address {
  final Geolocation? geolocation;
  final String? city;
  final String? street;
  final int? number;
  final String? zipcode;

  Address({
    this.geolocation,
    this.city,
    this.street,
    this.number,
    this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      geolocation: json['geolocation'] == null
          ? null
          : Geolocation.fromJson(
              json['geolocation'],
            ),
      city: json['city'],
      street: json['street'],
      number: json['number'],
      zipcode: json['zipcode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'geolocation': geolocation?.toJson(),
      'city': city,
      'street': street,
      'number': number,
      'zipcode': zipcode,
    };
  }
}

class Geolocation {
  final String? lat;
  final String? long;
  Geolocation({
    this.lat,
    this.long,
  });

  factory Geolocation.fromJson(Map<String, dynamic> json) {
    return Geolocation(
      lat: json['lat'],
      long: json['long'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'long': long,
    };
  }
}

class Name {
  final String? firstname;
  final String? lastname;

  Name({
    this.firstname,
    this.lastname,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstname: json['firstname'],
      lastname: json['lastname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
    };
  }
}

class LoggedUser {
  factory LoggedUser() {
    return _instance;
  }
  LoggedUser._privateConstructor();
  static final LoggedUser _instance = LoggedUser._privateConstructor();

  num? id;
  String? email;
  String? username;
  String? password;
  Name? name;
  String? phone;
  Address? address;
  int? v;

  factory LoggedUser.fromJson(Map<String, dynamic> json) {
    return LoggedUser()
      ..id = json['id']
      ..email = json['email']
      ..username = json['username']
      ..password = json['password']
      ..name = json['name'] == null ? null : Name.fromJson(json['name'])
      ..phone = json['phone']
      ..address =
          json['address'] == null ? null : Address.fromJson(json['address'])
      ..v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      'name': name?.toJson(),
      'phone': phone,
      'address': address?.toJson(),
      '__v': v,
    };
  }
}
