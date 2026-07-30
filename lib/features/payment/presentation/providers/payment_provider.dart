import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/payment_remote_ds.dart';
import '../data/repositories/payment_repository_impl.dart';
import '../domain/use_cases/payment_usecases.dart';
import '../data/models/payment_models.dart';

// ---- Dependencies ----
final paymentRemoteDataSourceProvider = Provider<PaymentRemoteDataSource>((ref) {
  return PaymentRemoteDataSourceImpl();
});

final paymentRepositoryProvider = Provider<PaymentRepositoryImpl>((ref) {
  final remoteDS = ref.read(paymentRemoteDataSourceProvider);
  return PaymentRepositoryImpl(remoteDS);
});

final initiatePaymentUseCaseProvider = Provider<InitiatePaymentUseCase>((ref) {
  final repo = ref.read(paymentRepositoryProvider);
  return InitiatePaymentUseCase(repo);
});

final verifyPaymentUseCaseProvider = Provider<VerifyPaymentUseCase>((ref) {
  final repo = ref.read(paymentRepositoryProvider);
  return VerifyPaymentUseCase(repo);
});

final getWalletSummaryUseCaseProvider = Provider<GetWalletSummaryUseCase>((ref) {
  final repo = ref.read(paymentRepositoryProvider);
  return GetWalletSummaryUseCase(repo);
});

final getTransactionsUseCaseProvider = Provider<GetTransactionsUseCase>((ref) {
  final repo = ref.read(paymentRepositoryProvider);
  return GetTransactionsUseCase(repo);
});

final refundPaymentUseCaseProvider = Provider<RefundPaymentUseCase>((ref) {
  final repo = ref.read(paymentRepositoryProvider);
  return RefundPaymentUseCase(repo);
});

// ---- Payment State ----
class PaymentState {
  final bool isLoading;
  final WalletSummary? walletSummary;
  final List<WalletTransaction> transactions;
  final PaymentResponse? paymentResponse;
  final String? errorMessage;

  const PaymentState({
    this.isLoading = false,
    this.walletSummary,
    this.transactions = const [],
    this.paymentResponse,
    this.errorMessage,
  });

  PaymentState copyWith({
    bool? isLoading,
    WalletSummary? walletSummary,
    List<WalletTransaction>? transactions,
    PaymentResponse? paymentResponse,
    String? errorMessage,
  }) {
    return PaymentState(
      isLoading: isLoading ?? this.isLoading,
      walletSummary: walletSummary ?? this.walletSummary,
      transactions: transactions ?? this.transactions,
      paymentResponse: paymentResponse ?? this.paymentResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ---- Payment Notifier ----
class PaymentNotifier extends StateNotifier<PaymentState> {
  final InitiatePaymentUseCase _initiatePayment;
  final VerifyPaymentUseCase _verifyPayment;
  final GetWalletSummaryUseCase _getWalletSummary;
  final GetTransactionsUseCase _getTransactions;
  final RefundPaymentUseCase _refundPayment;

  PaymentNotifier(
    this._initiatePayment,
    this._verifyPayment,
    this._getWalletSummary,
    this._getTransactions,
    this._refundPayment,
  ) : super(const PaymentState());

  Future<void> initiatePayment(PaymentRequest request) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response = await _initiatePayment(request);
      state = state.copyWith(isLoading: false, paymentResponse: response);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> verifyPayment(String paymentId, String orderId, String signature) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response = await _verifyPayment(paymentId, orderId, signature);
      state = state.copyWith(isLoading: false, paymentResponse: response);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> loadWalletSummary(String userId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final summary = await _getWalletSummary(userId);
      state = state.copyWith(isLoading: false, walletSummary: summary);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> loadTransactions(String userId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final transactions = await _getTransactions(userId);
      state = state.copyWith(isLoading: false, transactions: transactions);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> refundPayment(String paymentId, double amount) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response = await _refundPayment(paymentId, amount);
      state = state.copyWith(isLoading: false, paymentResponse: response);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void resetError() {
    state = state.copyWith(errorMessage: null);
  }
}

// ---- Payment Provider ----
final paymentProvider = StateNotifierProvider<PaymentNotifier, PaymentState>((ref) {
  final initiate = ref.read(initiatePaymentUseCaseProvider);
  final verify = ref.read(verifyPaymentUseCaseProvider);
  final wallet = ref.read(getWalletSummaryUseCaseProvider);
  final transactions = ref.read(getTransactionsUseCaseProvider);
  final refund = ref.read(refundPaymentUseCaseProvider);
  return PaymentNotifier(initiate, verify, wallet, transactions, refund);
});