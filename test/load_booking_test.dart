import 'package:flutter_test/flutter_test.dart';
import 'package:truck_loads_uae/src/features/load_booking/data/datasources/mock_load_booking_data_source.dart';
import 'package:truck_loads_uae/src/features/load_booking/data/repositories/mock_load_booking_repository.dart';
import 'package:truck_loads_uae/src/features/load_booking/domain/entities/load_booking.dart';

void main() {
  group('MockLoadBookingRepository', () {
    late MockLoadBookingRepository repository;

    setUp(() {
      repository = MockLoadBookingRepository(
        dataSource: MockLoadBookingDataSource(),
      );
    });

    test('submitBooking assigns waybill ID and creates queued booking', () async {
      final booking = LoadBooking(
        id: '',
        fullName: 'Al Futtaim Logistics',
        phoneNumber: '+971 50 123 4567',
        pickupLocation: 'JAFZA South Gate 4',
        dropoffLocation: 'Mussafah ICAD 1',
        truckType: '3-ton',
        preferredPickupTime: DateTime.now().add(const Duration(hours: 3)),
        cargoDescription: '2 pallets of electronic parts',
        createdAt: DateTime.now(),
      );

      final result = await repository.submitBooking(booking);

      expect(result.id, startsWith('DXB-'));
      expect(result.fullName, 'Al Futtaim Logistics');
      expect(result.status, BookingStatus.queued);
      expect(result.estimatedCallSeconds, 402);

      final recent = await repository.getRecentBookings();
      expect(recent.length, 1);
      expect(recent.first.id, result.id);
    });

    test('submitQuickInquiry returns true', () async {
      final success = await repository.submitQuickInquiry(
        name: 'Rashid Khan',
        contact: '+971 55 999 8888',
        details: 'Weekly freight route required from DIP to Mussafah',
      );

      expect(success, isTrue);
    });
  });
}
