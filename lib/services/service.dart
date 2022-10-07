// import 'package:acm/models/Movies.dart';
// import 'package:http/http.dart' as http;

// class RemoteService {
//   // ignore: body_might_complete_normally_nullable
//   Future<List<Movie>?> getMovie() async {
//     var client = http.Client();
//     var url = Uri.parse(
//         'https://api.themoviedb.org/3/movie/550?api_key=1a7863e3eb99c223a713957b3ed027a3');
//     var response = await client.get(url);
//     if (response.statusCode == 200) {
//       var json = response.body;
//       return movieFromJson(json);
//     }
//   }
// }

