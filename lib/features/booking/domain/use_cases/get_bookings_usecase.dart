import '../../data/models/booking_response.dart';
import '../../data/repositories/booking_repository_impl.dart';

class GetCustomerBookingsUseCase {
  final BookingRepositoryImpl repository;

  GetCustomerBookingsUseCase(this.repository);

  Future<List<BookingModel>> call(String customerId) async {
    return await repository.getCustomerBookings(customerId);
  }
}