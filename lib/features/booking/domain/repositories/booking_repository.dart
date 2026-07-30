import '../data/models/booking_request.dart';
import '../data/models/booking_response.dart';

abstract class BookingRepository {
  Future<BookingModel> createBooking(CreateBookingRequest request);
  Future<BookingModel> getBooking(String bookingId);
  Future<List<BookingModel>> getCustomerBookings(String customerId);
  Future<List<BookingModel>> getProviderBookings(String providerId);
  Future<BookingModel> updateBooking(UpdateBookingRequest request);
  Future<void> cancelBooking(String bookingId);
  Future<void> confirmArrival(String bookingId, String otp);
  Future<void> confirmStart(String bookingId, String otp);
  Future<void> confirmEnd(String bookingId, String otp);
}