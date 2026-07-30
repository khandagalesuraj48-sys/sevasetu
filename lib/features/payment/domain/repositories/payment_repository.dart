import '../data/models/payment_models.dart';

abstract class PaymentRepository {
  Future<PaymentResponse> initiatePayment(PaymentRequest request);
  Future<PaymentResponse> verifyPayment(String razorpayPaymentId, String razorpayOrderId, String razorpaySignature);
  Future<WalletSummary> getWalletSummary(String userId);
  Future<List<WalletTransaction>> getTransactions(String userId);
  Future<PaymentResponse> refundPayment(String paymentId, double amount);
}