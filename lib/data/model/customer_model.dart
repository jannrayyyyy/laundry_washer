// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../domain/entity/customer_entity.dart';

class CustomerModel extends CustomerEntity {
  const CustomerModel({
    super.uid,
    required super.fullname,
    required super.email,
    required super.phone,
    required super.fbLink,
    super.address,
    super.imageLink,
    super.coordinates,
  });

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      uid: map['uid'],
      fullname: map['fullname'] ?? "",
      email: map['email'] ?? "",
      phone: map['phone'] ?? "",
      fbLink: map['fbLink'] ?? "",
      address: map['address'],
      imageLink: map['imageLink'],
      coordinates: map['coordinates'],
    );
  }
  factory CustomerModel.fromEntity(CustomerEntity entity) {
    return CustomerModel(
      uid: entity.uid,
      fullname: entity.fullname,
      email: entity.email,
      phone: entity.phone,
      fbLink: entity.fbLink,
      address: entity.address,
      imageLink: entity.imageLink,
      coordinates: entity.coordinates,
    );
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'fullname': fullname,
        'email': email,
        'phone': phone,
        'fbLink': fbLink,
        'address': address,
        'imageLink': imageLink,
        'coordinates': coordinates,
      };
}
