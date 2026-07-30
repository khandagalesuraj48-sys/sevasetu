import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/payment_provider.dart';

class WalletScreen extends ConsumerStatefulWidget {
  final String userId;
  const WalletScreen({super.key, required this.userId});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  @override
  void initState() {
    super.initState();
    final paymentNotifier = ref.read(paymentProvider.notifier);
    paymentNotifier.loadWalletSummary(widget.userId);
    paymentNotifier.loadTransactions(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final paymentState = ref.watch(paymentProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Wallet')),
      body: paymentState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Wallet Balance
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor.withValues(alpha: 0.7)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Available Balance',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '₹${paymentState.walletSummary?.balance?.toStringAsFixed(2) ?? '0.00'}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStat('Total Credited', paymentState.walletSummary?.totalCredited ?? 0),
                          _buildStat('Total Debited', paymentState.walletSummary?.totalDebited ?? 0),
                        ],
                      ),
                    ],
                  ),
                ),
                // Transactions List
                Expanded(
                  child: paymentState.transactions.isEmpty
                      ? const Center(child: Text('No transactions yet.'))
                      : ListView.builder(
                          itemCount: paymentState.transactions.length,
                          itemBuilder: (context, index) {
                            final tx = paymentState.transactions[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: tx.type == 'credit' ? Colors.green : Colors.red,
                                  child: Icon(
                                    tx.type == 'credit' ? Icons.arrow_upward : Icons.arrow_downward,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text(tx.description),
                                subtitle: Text(tx.createdAt),
                                trailing: Text(
                                  '${tx.type == 'credit' ? '+' : '-'}₹${tx.amount.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: tx.type == 'credit' ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildStat(String label, double value) {
    return Column(
      children: [
        Text(
          '₹${value.toStringAsFixed(2)}',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}