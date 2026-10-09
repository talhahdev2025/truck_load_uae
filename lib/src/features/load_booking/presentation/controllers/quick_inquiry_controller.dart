import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'load_booking_controller.dart';

class QuickInquiryController extends AutoDisposeAsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    return false; // Idle
  }

  Future<void> submitInquiry({
    required String name,
    required String contact,
    required String details,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(loadBookingRepositoryProvider);
      return await repository.submitQuickInquiry(
        name: name,
        contact: contact,
        details: details,
      );
    });
  }

  void reset() {
    state = const AsyncValue.data(false);
  }
}

final quickInquiryControllerProvider =
    AutoDisposeAsyncNotifierProvider<QuickInquiryController, bool>(() {
  return QuickInquiryController();
});
