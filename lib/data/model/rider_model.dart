import '../../domain/entity/rider_entity.dart';

class RiderModel extends RiderEntity {
  const RiderModel({
    super.uid,
    required super.fullname,
    required super.email,
    required super.phone,
    required super.fbLink,
    super.address,
    super.imageLink,
    super.coordinates,
    required super.status,
  });

  factory RiderModel.fromMap(Map<String, dynamic> map) {
    return RiderModel(
      uid: map['uid'],
      fullname: map['fullname'] ?? "",
      email: map['email'] ?? "",
      phone: map['phone'] ?? "",
      fbLink: map['fbLink'] ?? "",
      address: map['address'],
      imageLink: map['imageLink'],
      coordinates: map['coordinates'],
      status: map['status'] ?? false,
    );
  }

  factory RiderModel.fromEntity(RiderEntity entity) {
    return RiderModel(
      uid: entity.uid,
      fullname: entity.fullname,
      email: entity.email,
      phone: entity.phone,
      fbLink: entity.fbLink,
      address: entity.address,
      imageLink: entity.imageLink,
      coordinates: entity.coordinates,
      status: entity.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'fbLink': fbLink,
      'address': address,
      'imageLink': imageLink,
      'coordinates': coordinates,
      'status': status,
    };
  }
}
