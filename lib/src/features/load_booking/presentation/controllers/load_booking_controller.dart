import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/load_booking.dart';
import '../../domain/repositories/load_booking_repository.dart';
import '../../data/repositories/load_booking_repository_impl.dart';

/// Provider for the LoadBookingRepository (Mock or Firestore)
final loadBookingRepositoryProvider = Provider<LoadBookingRepository>((ref) {
  return LoadBookingRepositoryImpl();
});

/// Shared provider for the currently selected truck type (defaults to '3-ton')
final selectedTruckTypeProvider = StateProvider<String>((ref) => '3-ton');

/// AsyncNotifier managing load booking creation state
class LoadBookingController extends AutoDisposeAsyncNotifier<LoadBooking?> {
  @override
  Future<LoadBooking?> build() async {
    return null; // Initial idle state
  }

  Future<void> submitBooking({
    required String fullName,
    required String phoneNumber,
    required String pickupLocation,
    required String dropoffLocation,
    required String truckType,
    required DateTime preferredPickupTime,
    String cargoDescription = '',
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(loadBookingRepositoryProvider);
      final bookingPayload = LoadBooking(
        id: '', // Will be assigned by data source
        fullName: fullName,
        phoneNumber: phoneNumber,
        pickupLocation: pickupLocation,
        dropoffLocation: dropoffLocation,
        truckType: truckType,
        preferredPickupTime: preferredPickupTime,
        cargoDescription: cargoDescription,
        createdAt: DateTime.now(),
      );

      await repository.submitBooking(bookingPayload);
      return bookingPayload;
    });
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

final loadBookingControllerProvider =
    AutoDisposeAsyncNotifierProvider<LoadBookingController, LoadBooking?>(() {
      return LoadBookingController();
    });
