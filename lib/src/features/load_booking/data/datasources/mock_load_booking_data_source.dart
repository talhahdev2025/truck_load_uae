import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/load_booking_model.dart';
import '../../domain/entities/load_booking.dart';

class FirestoreRemoteDataSource {
  final FirebaseFirestore _firestore;
  FirestoreRemoteDataSource(this._firestore);

  Future<void> createBooking(LoadBookingModel booking) async {
    try {
      final docRef = _firestore.collection('bookings').doc();

      final bookingData = {
        'fullName': booking.fullName,
        'id': booking.id,
        'phoneNumber': booking.phoneNumber,
        'pickupLocation': booking.pickupLocation,
        'dropoffLocation': booking.dropoffLocation,
        'truckType': booking.truckType,
        'preferredPickupTime': booking.preferredPickupTime.toIso8601String(),
        'cargoDescription': booking.cargoDescription,
        'createdAt': DateTime.now().toIso8601String(),
        'status': BookingStatus.queued.name,
      };
      await docRef.set(bookingData);
    } catch (e) {
      throw Exception('Failed to create booking: $e');
    }
  }

  Future<bool> saveInquiry({
    required String name,
    required String contact,
    required String details,
  }) async {
    try {
      final docRef = _firestore.collection('inquiries').doc();
      final inquiryData = {
        'name': name,
        'contact': contact,
        'details': details,
        'createdAt': DateTime.now().toIso8601String(),
      };
      await docRef.set(inquiryData);
      return true;
    } catch (e) {
      throw Exception('Failed to save inquiry: $e');
    }
  }
}
