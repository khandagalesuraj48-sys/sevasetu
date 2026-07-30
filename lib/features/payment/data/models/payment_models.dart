class PaymentRequest {
  final String bookingId;
  final double amount;
  final String paymentMethod; // 'razorpay', 'wallet', 'cash'
  final String? couponCode;

  PaymentRequest({
    required this.bookingId,
    required this.amount,
    required this.paymentMethod,
    this.couponCode,
  });

  Map<String, dynamic> toJson() => {
    'bookingId': bookingId,
    'amount': amount,
    'paymentMethod': paymentMethod,
    'couponCode': couponCode,
  };
}

class PaymentResponse {
  final bool success;
  final String? paymentId;
  final String? orderId;
  final String? razorpaySignature;
  final String? message;

  PaymentResponse({
    required this.success,
    this.paymentId,
    this.orderId,
    this.razorpaySignature,
    this.message,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) => PaymentResponse(
    success: json['success'] ?? false,
    paymentId: json['paymentId'],
    orderId: json['orderId'],
    razorpaySignature: json['razorpaySignature'],
    message: json['message'],
  );
}

class WalletTransaction {
  final String id;
  final String userId;
  final double amount;
  final String type; // 'credit', 'debit'
  final String description;
  final String? bookingId;
  final String createdAt;

  WalletTransaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    required this.description,
    this.bookingId,
    required this.createdAt,
  });

  factory WalletTransaction.fromJson(Map<String, dynamic> json) => WalletTransaction(
    id: json['id'] ?? '',
    userId: json['userId'] ?? '',
    amount: (json['amount'] ?? 0).toDouble(),
    type: json['type'] ?? 'credit',
    description: json['description'] ?? '',
    bookingId: json['bookingId'],
    createdAt: json['createdAt'] ?? '',
  );
}

class WalletSummary {
  final double balance;
  final double totalCredited;
  final double totalDebited;
  final int transactionCount;

  WalletSummary({
    required this.balance,
    required this.totalCredited,
    required this.totalDebited,
    required this.transactionCount,
  });

  factory WalletSummary.fromJson(Map<String, dynamic> json) => WalletSummary(
    balance: (json['balance'] ?? 0).toDouble(),
    totalCredited: (json['totalCredited'] ?? 0).toDouble(),
    totalDebited: (json['totalDebited'] ?? 0).toDouble(),
    transactionCount: json['transactionCount'] ?? 0,
  );
}