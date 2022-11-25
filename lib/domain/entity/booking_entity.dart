// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'customer_entity.dart';

class BookingEntity extends Equatable {
  @override
  List<Object?> get props => [uid];
  String? uid;
  final String category;
  final int? quantity;
  final int? kg;
  final double payment;
  final String paymentMethod;
  final String pickUpDate;
  final String deliveryDate;
  final String createdBy;
  final String createdAt;
  final int load;
  final String? riderId;
  final bool isCompleted;
  final CustomerEntity? customer;
  final int bookingStatus;
  final String? modeOfPayment;
  final int scheduleType;
  final List? proofs;
  final bool? isFree;
  final String? reason;
  final String? note;
  final Map? pickUpCoordinates;
  final String? pickUpAddress;
  final int? chargeFee;
  bool? isSelected;
  BookingEntity({
    this.uid = "",
    required this.category,
    this.quantity,
    this.kg,
    required this.payment,
    required this.paymentMethod,
    required this.pickUpDate,
    required this.deliveryDate,
    required this.createdBy,
    required this.createdAt,
    required this.load,
    this.riderId,
    required this.isCompleted,
    this.customer,
    required this.bookingStatus,
    this.modeOfPayment,
    required this.scheduleType,
    required this.proofs,
    this.isFree,
    this.reason,
    this.note,
    this.pickUpCoordinates,
    this.pickUpAddress,
    this.chargeFee,
    this.isSelected = false,
  });
}
