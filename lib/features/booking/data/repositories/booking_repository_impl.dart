import '../datasources/booking_remote_ds.dart';
import '../../domain/repositories/booking_repository.dart';
import '../models/booking_request.dart';
import '../models/booking_response.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl(this.remoteDataSource);

  @override
  Future<BookingModel> createBooking(CreateBookingRequest request) async {
    return await remoteDataSource.createBooking(request);
  }

  @override
  Future<BookingModel> getBooking(String bookingId) async {
    return await remoteDataSource.getBooking(bookingId);
  }

  @override
  Future<List<BookingModel>> getCustomerBookings(String customerId) async {
    return await remoteDataSource.getBookingsByCustomer(customerId);
  }

  @override
  Future<List<BookingModel>> getProviderBookings(String providerId) async {
    return await remoteDataSource.getBookingsByProvider(providerId);
  }

  @override
  Future<BookingModel> updateBooking(UpdateBookingRequest request) async {
    return await remoteDataSource.updateBooking(request);
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    await remoteDataSource.cancelBooking(bookingId);
  }

  @override
  Future<void> confirmArrival(String bookingId, String otp) async {
    await remoteDataSource.confirmArrival(bookingId, otp);
  }

  @override
  Future<void> confirmStart(String bookingId, String otp) async {
    await remoteDataSource.confirmStart(bookingId, otp);
  }

  @override
  Future<void> confirmEnd(String bookingId, String otp) async {
    await remoteDataSource.confirmEnd(bookingId, otp);
  }
}