// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  @override
  List<Object?> get props => [
        uid,
        email,
        phone,
      ];

  final String? uid;
  final String fullname;
  final String email;
  final String phone;
  final String fbLink;
  final String? address;
  final String? imageLink;
  final Map? coordinates;
  const CustomerEntity({
    this.uid,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.fbLink,
    this.address,
    this.imageLink,
    this.coordinates,
  });
}
