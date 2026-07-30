import '../../data/models/booking_request.dart';
import '../../data/models/booking_response.dart';
import '../../data/repositories/booking_repository_impl.dart';

class CreateBookingUseCase {
  final BookingRepositoryImpl repository;

  CreateBookingUseCase(this.repository);

  Future<BookingModel> call(CreateBookingRequest request) async {
    return await repository.createBooking(request);
  }
}