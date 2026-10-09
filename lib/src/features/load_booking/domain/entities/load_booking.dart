enum BookingStatus {
  queued('Queued'),
  underReview('Under Review'),
  dispatched('Dispatched'),
  completed('Completed');

  const BookingStatus(this.displayName);
  final String displayName;
}

class LoadBooking {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String pickupLocation;
  final String dropoffLocation;
  final String truckType;
  final DateTime preferredPickupTime;
  final String cargoDescription;
  final DateTime createdAt;
  final BookingStatus status;
  final int estimatedCallSeconds;

  const LoadBooking({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.truckType,
    required this.preferredPickupTime,
    this.cargoDescription = '',
    required this.createdAt,
    this.status = BookingStatus.queued,
    this.estimatedCallSeconds = 402, // 6 mins 42 secs
  });

  String get truckTypeDisplayName {
    switch (truckType.toLowerCase()) {
      case '1-ton':
        return '1-Ton Pickup (Express Courier)';
      case '3-ton':
        return '3-Ton Pickup (Box / Standard)';
      case '7-ton':
        return '7-Ton Heavy Truck (Bulk Pallets)';
      case 'flatbed':
        return 'Flatbed Open Trailer (Machinery / Steel)';
      case 'chiller':
        return 'Chiller / Freezer Box (+2°C to -18°C)';
      default:
        return truckType;
    }
  }

  LoadBooking copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? pickupLocation,
    String? dropoffLocation,
    String? truckType,
    DateTime? preferredPickupTime,
    String? cargoDescription,
    DateTime? createdAt,
    BookingStatus? status,
    int? estimatedCallSeconds,
  }) {
    return LoadBooking(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      dropoffLocation: dropoffLocation ?? this.dropoffLocation,
      truckType: truckType ?? this.truckType,
      preferredPickupTime: preferredPickupTime ?? this.preferredPickupTime,
      cargoDescription: cargoDescription ?? this.cargoDescription,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      estimatedCallSeconds: estimatedCallSeconds ?? this.estimatedCallSeconds,
    );
  }
}
