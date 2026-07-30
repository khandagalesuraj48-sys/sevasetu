import '../../data/models/payment_models.dart';
import '../../data/repositories/payment_repository_impl.dart';

class InitiatePaymentUseCase {
  final PaymentRepositoryImpl repository;
  InitiatePaymentUseCase(this.repository);
  Future<PaymentResponse> call(PaymentRequest request) async {
    return await repository.initiatePayment(request);
  }
}

class VerifyPaymentUseCase {
  final PaymentRepositoryImpl repository;
  VerifyPaymentUseCase(this.repository);
  Future<PaymentResponse> call(String paymentId, String orderId, String signature) async {
    return await repository.verifyPayment(paymentId, orderId, signature);
  }
}

class GetWalletSummaryUseCase {
  final PaymentRepositoryImpl repository;
  GetWalletSummaryUseCase(this.repository);
  Future<WalletSummary> call(String userId) async {
    return await repository.getWalletSummary(userId);
  }
}

class GetTransactionsUseCase {
  final PaymentRepositoryImpl repository;
  GetTransactionsUseCase(this.repository);
  Future<List<WalletTransaction>> call(String userId) async {
    return await repository.getTransactions(userId);
  }
}

class RefundPaymentUseCase {
  final PaymentRepositoryImpl repository;
  RefundPaymentUseCase(this.repository);
  Future<PaymentResponse> call(String paymentId, double amount) async {
    return await repository.refundPayment(paymentId, amount);
  }
}