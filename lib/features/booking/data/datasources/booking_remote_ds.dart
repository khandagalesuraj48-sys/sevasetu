import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/booking_request.dart';
import '../models/booking_response.dart';

abstract class BookingRemoteDataSource {
  Future<BookingModel> createBooking(CreateBookingRequest request);
  Future<BookingModel> getBooking(String bookingId);
  Future<List<BookingModel>> getBookingsByCustomer(String customerId);
  Future<List<BookingModel>> getBookingsByProvider(String providerId);
  Future<BookingModel> updateBooking(UpdateBookingRequest request);
  Future<void> cancelBooking(String bookingId);
  Future<void> confirmArrival(String bookingId, String otp);
  Future<void> confirmStart(String bookingId, String otp);
  Future<void> confirmEnd(String bookingId, String otp);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final Dio dio = DioClient.instance.dio;

  @override
  Future<BookingModel> createBooking(CreateBookingRequest request) async {
    try {
      final response = await dio.post('/bookings', data: request.toJson());
      return BookingModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  @override
  Future<BookingModel> getBooking(String bookingId) async {
    try {
      final response = await dio.get('/bookings/$bookingId');
      return BookingModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  @override
  Future<List<BookingModel>> getBookingsByCustomer(String customerId) async {
    try {
      final response = await dio.get('/bookings/customer/$customerId');
      return (response.data as List).map((json) => BookingModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  @override
  Future<List<BookingModel>> getBookingsByProvider(String providerId) async {
    try {
      final response = await dio.get('/bookings/provider/$providerId');
      return (response.data as List).map((json) => BookingModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  @override
  Future<BookingModel> updateBooking(UpdateBookingRequest request) async {
    try {
      final response = await dio.put('/bookings/${request.bookingId}', data: request.toJson());
      return BookingModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    try {
      await dio.delete('/bookings/$bookingId');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  @override
  Future<void> confirmArrival(String bookingId, String otp) async {
    try {
      await dio.post('/bookings/$bookingId/arrival', data: {'otp': otp});
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  @override
  Future<void> confirmStart(String bookingId, String otp) async {
    try {
      await dio.post('/bookings/$bookingId/start', data: {'otp': otp});
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  @override
  Future<void> confirmEnd(String bookingId, String otp) async {
    try {
      await dio.post('/bookings/$bookingId/end', data: {'otp': otp});
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }
}