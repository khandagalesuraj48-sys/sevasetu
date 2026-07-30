import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/home_provider.dart';
import '../../core/theme/theme_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<Widget> _pages = const [
    DashboardPage(),
    ServicesPage(),
    BookingsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    final homeNotifier = ref.read(homeProvider.notifier);

    return Scaffold(
      body: _pages[homeState.selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: homeState.selectedIndex,
        onDestinationSelected: homeNotifier.changeTab,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search_outlined), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.history_outlined), label: 'Bookings'),
          NavigationDestination(icon: Icon(Icons.person_outlined), label: 'Profile'),
        ],
      ),
    );
  }
}

// ---- Dashboard Page ----
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SevaSetu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Text(
              'Hello, User!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'What service do you need today?',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey[100]
                    : Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search services...',
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Category Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: const [
                ServiceCard(icon: Icons.home_repair_service, label: 'Home', color: Color(0xFF1A73E8)),
                ServiceCard(icon: Icons.car_repair, label: 'Vehicle', color: Color(0xFF34A853)),
                ServiceCard(icon: Icons.emergency, label: 'Emergency', color: Color(0xFFEA4335)),
                ServiceCard(icon: Icons.construction, label: 'Construction', color: Color(0xFFFBBC04)),
              ],
            ),
            const SizedBox(height: 24),
            // Recent Bookings
            Text(
              'Recent Bookings',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            const RecentBookingCard(
              service: 'AC Service',
              provider: 'Mr. Sharma',
              status: 'Completed',
              date: 'Today, 2:30 PM',
            ),
            const RecentBookingCard(
              service: 'Plumbing',
              provider: 'Mr. Patel',
              status: 'In Progress',
              date: 'Today, 10:00 AM',
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          context.go('/create-booking/demo-provider/demo-service');
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecentBookingCard extends StatelessWidget {
  final String service;
  final String provider;
  final String status;
  final String date;

  const RecentBookingCard({
    super.key,
    required this.service,
    required this.provider,
    required this.status,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final color = status == 'Completed' ? Colors.green : Colors.orange;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.build),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service, style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text(provider, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  Text(date, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(status, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}

// ---- Explore Page ----
class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore Services')),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
        children: const [
          CategoryTile(icon: Icons.ac_unit, label: 'AC Repair'),
          CategoryTile(icon: Icons.plumbing, label: 'Plumbing'),
          CategoryTile(icon: Icons.electrical_services, label: 'Electrical'),
          CategoryTile(icon: Icons.car_repair, label: 'Car Service'),
          CategoryTile(icon: Icons.construction, label: 'Construction'),
          CategoryTile(icon: Icons.cleaning_services, label: 'Cleaning'),
        ],
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryTile({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

// ---- Bookings Page ----
class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          final statuses = ['Completed', 'In Progress', 'Pending', 'Cancelled', 'Completed'];
          final services = ['AC Repair', 'Plumbing', 'Electrical', 'Carpentry', 'Painting'];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                child: Text('${index + 1}', style: TextStyle(color: Theme.of(context).primaryColor)),
              ),
              title: Text(services[index % services.length]),
              subtitle: Text('Provider: Demo ${index + 1}'),
              trailing: Chip(
                label: Text(statuses[index % statuses.length]),
                backgroundColor: index % 2 == 0 ? Colors.green.shade100 : Colors.orange.shade100,
                labelStyle: TextStyle(color: index % 2 == 0 ? Colors.green : Colors.orange),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---- Profile Page ----
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ref = context.read<ProviderContainer>();
    final themeNotifier = ref.watch(themeNotifierProvider);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 12),
            const Text('Demo User', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text('demo@sevasetu.com', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.wallet),
              title: const Text('My Wallet'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => context.go('/wallet/demo-user'),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Booking History'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => context.go('/bookings/demo-user'),
            ),
            ListTile(
              leading: const Icon(Icons.brightness_4),
              title: Text(themeMode == ThemeMode.light ? 'Dark Mode' : 'Light Mode'),
              trailing: Switch(
                value: themeMode == ThemeMode.dark,
                onChanged: (_) => themeNotifier.toggleTheme(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.go('/login'),
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}