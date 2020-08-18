import 'dart:convert';

class User {
  final String uid;
  final String name;
  final String phone;
  final String email;
  final String location;
  final String title;
  final String description;

  User({
    this.uid,
    this.name,
    this.phone,
    this.email,
    this.location,
    this.title,
    this.description,
  });

  User copyWith({
    String uid,
    String name,
    String phone,
    String email,
    String location,
    String title,
    String description,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      location: location ?? this.location,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
      'email': email,
      'location': location,
      'title': title,
      'description': description,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      uid: map['uid'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      location: map['location'],
      title: map['title'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(uid: $uid, name: $name, phone: $phone, email: $email, location: $location, title: $title, description: $description)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.uid == uid &&
        o.name == name &&
        o.phone == phone &&
        o.email == email &&
        o.location == location &&
        o.title == title &&
        o.description == description;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        location.hashCode ^
        title.hashCode ^
        description.hashCode;
  }
}
