import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<T>> fetchAPI<T>({
    required String apiUrl,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => fromJson(item as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load employees');
    }
}
