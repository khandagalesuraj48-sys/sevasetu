import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/booking_provider.dart';
import '../../data/models/booking_response.dart';

class BookingHistoryScreen extends ConsumerWidget {
  final String customerId;

  const BookingHistoryScreen({super.key, required this.customerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(bookingProvider);
    final bookingNotifier = ref.read(bookingProvider.notifier);

    Future.microtask(() => bookingNotifier.loadCustomerBookings(customerId));

    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: bookingState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : bookingState.bookings.isEmpty
              ? const Center(child: Text('No bookings yet.'))
              : ListView.builder(
                  itemCount: bookingState.bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookingState.bookings[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text('Booking #${booking.id.substring(0, 8)}'),
                        subtitle: Text('Status: ${booking.status}'),
                        trailing: booking.status == 'pending'
                            ? const Chip(label: Text('Pending'), backgroundColor: Colors.orange)
                            : booking.status == 'completed'
                                ? const Chip(label: Text('Completed'), backgroundColor: Colors.green)
                                : const Chip(label: Text('Cancelled'), backgroundColor: Colors.red),
                        onTap: () {
                          // Navigate to booking details
                        },
                      ),
                    );
                  },
                ),
    );
  }
}