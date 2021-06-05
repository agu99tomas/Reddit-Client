import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reddit_client_7_3_21/src/models/post_model.dart';

class PostProvider{

  Future<List<PostModel>> fetchPosts(String subreddit) async {
    final url = 'https://www.reddit.com/$subreddit.json';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      final Posts posts = Posts.fromJson(decodeData);
      return posts.posts;
    } else {
      throw Exception('Posts could not be loaded');
    }
  }
  


}