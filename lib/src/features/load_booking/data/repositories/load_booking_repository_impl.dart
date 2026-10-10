import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truck_loads_uae/src/features/load_booking/data/models/load_booking_model.dart';

import '../../domain/entities/load_booking.dart';
import '../../domain/repositories/load_booking_repository.dart';
import '../datasources/mock_load_booking_data_source.dart';

/// Implementation of LoadBookingRepository using MockLoadBookingDataSource.
class LoadBookingRepositoryImpl implements LoadBookingRepository {
  LoadBookingRepositoryImpl({FirestoreRemoteDataSource? dataSource})
    : _dataSource =
          dataSource ?? FirestoreRemoteDataSource(FirebaseFirestore.instance);

  final FirestoreRemoteDataSource _dataSource;

  int _counter = 8831;
  @override
  Future<void> submitBooking(LoadBooking booking) async {
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
    _dataSource.createBooking(createdModel);
  }

  // @override
  // Future<List<LoadBooking>> getRecentBookings() async {
  //   return _dataSource.getBookings();
  // }

  @override
  Future<bool> submitQuickInquiry({
    required String name,
    required String contact,
    required String details,
  }) async {
    return _dataSource.saveInquiry(
      name: name,
      contact: contact,
      details: details,
    );
  }
}
