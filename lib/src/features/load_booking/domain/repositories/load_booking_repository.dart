import '../entities/load_booking.dart';

/// Abstract contract for booking repository.
/// Easily interchangeable between Mock and Firestore in the data layer.
abstract class LoadBookingRepository {
  /// Submit a new load booking to dispatch
  Future<LoadBooking> submitBooking(LoadBooking booking);

  /// Fetch recently submitted bookings
  Future<List<LoadBooking>> getRecentBookings();

  /// Submit quick corporate inquiry
  Future<bool> submitQuickInquiry({
    required String name,
    required String contact,
    required String details,
  });
}
