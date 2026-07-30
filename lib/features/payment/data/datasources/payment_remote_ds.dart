import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/payment_models.dart';

abstract class PaymentRemoteDataSource {
  Future<PaymentResponse> initiatePayment(PaymentRequest request);
  Future<PaymentResponse> verifyPayment(String razorpayPaymentId, String razorpayOrderId, String razorpaySignature);
  Future<WalletSummary> getWalletSummary(String userId);
  Future<List<WalletTransaction>> getTransactions(String userId);
  Future<PaymentResponse> refundPayment(String paymentId, double amount);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final Dio dio = DioClient.instance.dio;

  @override
  Future<PaymentResponse> initiatePayment(PaymentRequest request) async {
    try {
      final response = await dio.post('/payments/initiate', data: request.toJson());
      return PaymentResponse.fromJson(response.data);
    } on DioException catch (e) {
      return PaymentResponse(success: false, message: e.response?.data['message'] ?? e.message);
    }
  }

  @override
  Future<PaymentResponse> verifyPayment(String razorpayPaymentId, String razorpayOrderId, String razorpaySignature) async {
    try {
      final response = await dio.post('/payments/verify', data: {
        'razorpayPaymentId': razorpayPaymentId,
        'razorpayOrderId': razorpayOrderId,
        'razorpaySignature': razorpaySignature,
      });
      return PaymentResponse.fromJson(response.data);
    } on DioException catch (e) {
      return PaymentResponse(success: false, message: e.response?.data['message'] ?? e.message);
    }
  }

  @override
  Future<WalletSummary> getWalletSummary(String userId) async {
    try {
      final response = await dio.get('/payments/wallet/$userId');
      return WalletSummary.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  @override
  Future<List<WalletTransaction>> getTransactions(String userId) async {
    try {
      final response = await dio.get('/payments/transactions/$userId');
      return (response.data as List).map((json) => WalletTransaction.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  @override
  Future<PaymentResponse> refundPayment(String paymentId, double amount) async {
    try {
      final response = await dio.post('/payments/refund', data: {'paymentId': paymentId, 'amount': amount});
      return PaymentResponse.fromJson(response.data);
    } on DioException catch (e) {
      return PaymentResponse(success: false, message: e.response?.data['message'] ?? e.message);
    }
  }
}