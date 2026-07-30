import 'package:go_router/go_router.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/booking/presentation/screens/create_booking_screen.dart';
import '../features/booking/presentation/screens/booking_history_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/create-booking/:providerId/:serviceId',
        name: 'create-booking',
        builder: (context, state) {
          final params = state.pathParameters;
          return CreateBookingScreen(
            providerId: params['providerId']!,
            serviceId: params['serviceId']!,
          );
        },
      ),
      GoRoute(
        path: '/bookings/:customerId',
        name: 'bookings',
        builder: (context, state) {
          final params = state.pathParameters;
          return BookingHistoryScreen(customerId: params['customerId']!);
        },
      ),
    ],
  );
}