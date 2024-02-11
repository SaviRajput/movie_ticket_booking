import 'package:book_my_movie/data/data_source/local/database_services.dart';
import 'package:book_my_movie/domain/data_models/movie_booking_model.dart';
import 'package:book_my_movie/utils/injection_container.dart';

class MovieBookingRepository {
  final _database = getIt<DatabaseServices>();

  Future<int?> insertMovieBooking(MovieBookingModel booking) async {
    final Map<String, dynamic> data = {
      'name': booking.name,
      'time': booking.time,
      'movie_id': booking.movieId,
      'seat_numbers': booking.seatNumbers?.join(','),
      'ticket_number': booking.ticketNumber,
      'movie_image': booking.movieImage,
      'cinema_id': booking.cinemaId,
      // Serialize list to string
      'created_at': booking.createdAt,
      'updated_at': booking.updatedAt,
    };
    return await _database.insertData('movie_bookings', data);
  }

  Future<List<MovieBookingModel>?> getAllMovieBookings() async {
    try {
      final List<Map<String, dynamic>>? rows =
          await _database.customQuery('movie_bookings');

      return rows!.map((row) {
        return MovieBookingModel(
          id: row['id'],
          name: row['name'],
          time: row['time'],
          movieId: row['movie_id'],
          movieImage: row['movie_image'],
          ticketNumber: row['ticket_number'],
          seatNumbers: (row['seat_numbers'] as String).split(','),
          // Deserialize string to list
          createdAt: row['created_at'],
          updatedAt: row['updated_at'],
        );
      }).toList();
    } catch (e) {
      return null;
    }
  }
}
