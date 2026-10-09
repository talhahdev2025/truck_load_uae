import 'dart:math';
import 'package:truck_loads_uae/src/core/constants/app_constants.dart';

import '../models/load_booking_model.dart';
import '../../domain/entities/load_booking.dart';

/// Simulates asynchronous in-memory data store for load bookings.
/// Can be replaced with FirestoreRemoteDataSource later.
class MockLoadBookingDataSource {
  final List<LoadBookingModel> _bookings = [];
  int _counter = 8831;

  Future<LoadBookingModel> createBooking(LoadBooking booking) async {
    // Simulate real-time dispatch queue processing latency
    await Future.delayed(const Duration(milliseconds: 1200));

    final waybillId = 'DXB-$_counter';
    _counter += Random().nextInt(5) + 1;

    final createdModel = LoadBookingModel(
      id: waybillId,
      fullName: booking.fullName,
      phoneNumber: booking.phoneNumber,
      pickupLocation: booking.pickupLocation,
      dropoffLocation: booking.dropoffLocation,
      truckType: booking.truckType,
      preferredPickupTime: booking.preferredPickupTime,
      cargoDescription: booking.cargoDescription,
      createdAt: DateTime.now(),
      status: BookingStatus.queued,
      // estimatedCallSeconds: AppConstants.estimatedCallSeconds,
    );

    _bookings.insert(0, createdModel);
    return createdModel;
  }

  Future<List<LoadBookingModel>> getBookings() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.unmodifiable(_bookings);
  }

  Future<bool> saveInquiry({
    required String name,
    required String contact,
    required String details,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return true;
  }
}
