import '../../domain/entities/load_booking.dart';
import '../../domain/repositories/load_booking_repository.dart';
import '../datasources/mock_load_booking_data_source.dart';

/// Implementation of LoadBookingRepository using MockLoadBookingDataSource.
class MockLoadBookingRepository implements LoadBookingRepository {
  MockLoadBookingRepository({MockLoadBookingDataSource? dataSource})
      : _dataSource = dataSource ?? MockLoadBookingDataSource();

  final MockLoadBookingDataSource _dataSource;

  @override
  Future<LoadBooking> submitBooking(LoadBooking booking) async {
    return _dataSource.createBooking(booking);
  }

  @override
  Future<List<LoadBooking>> getRecentBookings() async {
    return _dataSource.getBookings();
  }

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
