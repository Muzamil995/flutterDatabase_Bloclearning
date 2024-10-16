import 'dart:convert';  // For jsonDecode
import 'package:database_practice/model/postmodel.dart';
import 'package:http/http.dart' as http;  // For HTTP requests

class PostRepository {
  // Fetches a list of posts from the provided API
  Future<List<PostModel>> fetchPost() async {
    try {
      final response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts/1/comments"),
      );

      if (response.statusCode == 200) {
        // Parse response body as a List of dynamic maps
        final body = jsonDecode(response.body) as List;

        // Map each element to PostModel and return the list
        return body.map((json) {
          return PostModel(
            id: json["id"],
            email: json["email"],
            body: json["body"],
          );
        }).toList();
      } else {
        throw Exception("Failed to load posts. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      // Catch any errors and throw an exception
      throw Exception("Error occurred while fetching posts: $e");
    }
  }
}
