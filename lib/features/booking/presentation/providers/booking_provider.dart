import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/booking_remote_ds.dart';
import '../data/repositories/booking_repository_impl.dart';
import '../domain/use_cases/create_booking_usecase.dart';
import '../domain/use_cases/get_bookings_usecase.dart';
import '../data/models/booking_request.dart';
import '../data/models/booking_response.dart';

// ---- Dependencies ----
final bookingRemoteDataSourceProvider = Provider<BookingRemoteDataSource>((ref) {
  return BookingRemoteDataSourceImpl();
});

final bookingRepositoryProvider = Provider<BookingRepositoryImpl>((ref) {
  final remoteDS = ref.read(bookingRemoteDataSourceProvider);
  return BookingRepositoryImpl(remoteDS);
});

final createBookingUseCaseProvider = Provider<CreateBookingUseCase>((ref) {
  final repo = ref.read(bookingRepositoryProvider);
  return CreateBookingUseCase(repo);
});

final getCustomerBookingsUseCaseProvider = Provider<GetCustomerBookingsUseCase>((ref) {
  final repo = ref.read(bookingRepositoryProvider);
  return GetCustomerBookingsUseCase(repo);
});

// ---- Booking State ----
class BookingState {
  final bool isLoading;
  final List<BookingModel> bookings;
  final BookingModel? currentBooking;
  final String? errorMessage;

  const BookingState({
    this.isLoading = false,
    this.bookings = const [],
    this.currentBooking,
    this.errorMessage,
  });

  BookingState copyWith({
    bool? isLoading,
    List<BookingModel>? bookings,
    BookingModel? currentBooking,
    String? errorMessage,
  }) {
    return BookingState(
      isLoading: isLoading ?? this.isLoading,
      bookings: bookings ?? this.bookings,
      currentBooking: currentBooking ?? this.currentBooking,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ---- Booking Notifier ----
class BookingNotifier extends StateNotifier<BookingState> {
  final CreateBookingUseCase _createBookingUseCase;
  final GetCustomerBookingsUseCase _getCustomerBookingsUseCase;

  BookingNotifier(
    this._createBookingUseCase,
    this._getCustomerBookingsUseCase,
  ) : super(const BookingState());

  Future<void> createBooking(CreateBookingRequest request) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final booking = await _createBookingUseCase(request);
      state = state.copyWith(
        isLoading: false,
        currentBooking: booking,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> loadCustomerBookings(String customerId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final bookings = await _getCustomerBookingsUseCase(customerId);
      state = state.copyWith(
        isLoading: false,
        bookings: bookings,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void resetError() {
    state = state.copyWith(errorMessage: null);
  }

  void setCurrentBooking(BookingModel booking) {
    state = state.copyWith(currentBooking: booking);
  }

  void clearCurrentBooking() {
    state = state.copyWith(currentBooking: null);
  }
}

// ---- Booking Provider ----
final bookingProvider = StateNotifierProvider<BookingNotifier, BookingState>((ref) {
  final createUC = ref.read(createBookingUseCaseProvider);
  final getUC = ref.read(getCustomerBookingsUseCaseProvider);
  return BookingNotifier(createUC, getUC);
});