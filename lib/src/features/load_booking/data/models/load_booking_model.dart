import '../../domain/entities/load_booking.dart';

/// Data transfer model for LoadBooking with json serialization
class LoadBookingModel extends LoadBooking {
  const LoadBookingModel({
    required super.id,
    required super.fullName,
    required super.phoneNumber,
    required super.pickupLocation,
    required super.dropoffLocation,
    required super.truckType,
    required super.preferredPickupTime,
    super.cargoDescription,
    required super.createdAt,
    super.status,
    super.estimatedCallSeconds,
  });

  factory LoadBookingModel.fromEntity(LoadBooking entity) {
    return LoadBookingModel(
      id: entity.id,
      fullName: entity.fullName,
      phoneNumber: entity.phoneNumber,
      pickupLocation: entity.pickupLocation,
      dropoffLocation: entity.dropoffLocation,
      truckType: entity.truckType,
      preferredPickupTime: entity.preferredPickupTime,
      cargoDescription: entity.cargoDescription,
      createdAt: entity.createdAt,
      status: entity.status,
      estimatedCallSeconds: entity.estimatedCallSeconds,
    );
  }

  factory LoadBookingModel.fromJson(Map<String, dynamic> json) {
    return LoadBookingModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      pickupLocation: json['pickupLocation'] as String,
      dropoffLocation: json['dropoffLocation'] as String,
      truckType: json['truckType'] as String,
      preferredPickupTime: DateTime.parse(json['preferredPickupTime'] as String),
      cargoDescription: (json['cargoDescription'] as String?) ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: BookingStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => BookingStatus.queued,
      ),
      estimatedCallSeconds: (json['estimatedCallSeconds'] as num?)?.toInt() ?? 402,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'pickupLocation': pickupLocation,
      'dropoffLocation': dropoffLocation,
      'truckType': truckType,
      'preferredPickupTime': preferredPickupTime.toIso8601String(),
      'cargoDescription': cargoDescription,
      'createdAt': createdAt.toIso8601String(),
      'status': status.name,
      'estimatedCallSeconds': estimatedCallSeconds,
    };
  }
}
