import '../datasources/payment_remote_ds.dart';
import '../../domain/repositories/payment_repository.dart';
import '../models/payment_models.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl(this.remoteDataSource);

  @override
  Future<PaymentResponse> initiatePayment(PaymentRequest request) async {
    return await remoteDataSource.initiatePayment(request);
  }

  @override
  Future<PaymentResponse> verifyPayment(String razorpayPaymentId, String razorpayOrderId, String razorpaySignature) async {
    return await remoteDataSource.verifyPayment(razorpayPaymentId, razorpayOrderId, razorpaySignature);
  }

  @override
  Future<WalletSummary> getWalletSummary(String userId) async {
    return await remoteDataSource.getWalletSummary(userId);
  }

  @override
  Future<List<WalletTransaction>> getTransactions(String userId) async {
    return await remoteDataSource.getTransactions(userId);
  }

  @override
  Future<PaymentResponse> refundPayment(String paymentId, double amount) async {
    return await remoteDataSource.refundPayment(paymentId, amount);
  }
}