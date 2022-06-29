import 'dart:convert';
import 'package:fimii/models/comment.dart';
import 'package:fimii/models/player.dart';
import 'package:fimii/models/post.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ApiService {
  final urlApi = "http://192.168.1.4:3000/";

  ///////////////////// POST /////////////////////////////
  Future<List<Post>> fetchAllPosts() async {
    Uri uri;

    uri = Uri.parse(urlApi + 'posts');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List res = json.decode(response.body);
      List<Post> allPosts = [];

      for (var element in res) {
        allPosts.add(Post.fromJson(element));
      }

      return allPosts;
    } else {
      throw Exception(response.body);
    }
  }


  Future<Post> fetchPost(String id) async {
    try {
      final response = await Dio().get(urlApi + 'posts/' + id);

      if (kDebugMode) {
        print('response ${response.data}');
      }

      return Post.fromJson(response.data);
    } on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        throw Exception(e.response.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        throw Exception(e.message);
      }
    }
  }

  createNewPost(Post post) async {
    try {
      final response = await Dio().post(urlApi + 'posts',
          data: post.toJson(),
          options: Options(contentType: Headers.formUrlEncodedContentType));

      if (kDebugMode) {
        print('response ${response.data}');
      }

      return response.data;
    } on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        throw Exception(e.response.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        throw Exception(e.message);
      }
    }
  }

  like(String email, Post post) async{
    try {
      final response = await Dio().post(urlApi + 'reaction',
          data: {'email': email, 'id': post.id},
          options: Options(contentType: Headers.formUrlEncodedContentType));

      if (kDebugMode) {
        print('response ${response.data}');
      }

      return response.data;
    } on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        throw Exception(e.response.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        throw Exception(e.message);
      }
    }
  }

  dislike(String email, Post post) async{
    try {
      final response = await Dio().delete(urlApi + 'reaction',
          data: {'email': email, 'id': post.id},
          options: Options(contentType: Headers.formUrlEncodedContentType));

      if (kDebugMode) {
        print('response ${response.data}');
      }

      return response.data;
    } on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        throw Exception(e.response.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        throw Exception(e.message);
      }
    }
  }

  ///////////////////////////// COMMENT ///////////////////////////////////

  Future<List<Comment>> fetchComments(String id) async {
    try {
      final response = await Dio().get(urlApi + 'comments/' + id);

      if (kDebugMode) {
        print('fetchComments response ${response.data}');
      }

      List<Comment> allComments = [];

      if(response.data is Iterable) {
        for (var element in response.data) {
          allComments.add(Comment.fromJson(element));
        }
      }

      return allComments;
    } on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        throw Exception(e.response.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        throw Exception(e.message);
      }
    }
  }

  postComment(Comment comment) async {
    try {
      final response = await Dio().post(urlApi + 'comments/' + comment.postId,
          data: comment.toJson(),
          options: Options(contentType: Headers.formUrlEncodedContentType));

      if (kDebugMode) {
        print('response ${response.data}');
      }

      return response.data;
    } on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        throw Exception(e.response.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        throw Exception(e.message);
      }
    }
  }

  /////////////////////// PLAYER //////////////////////////////////////////
  Future<Player> fetchAccount(String email) async {
    try {
      final response = await Dio().get(urlApi + 'account/' + email);

      if (kDebugMode) {
        print('response ${response.data}');
      }

      return Player.fromJson(response.data);
    } on DioError catch(e) {
      if (e.response != null) {
        throw Exception(e.response.data);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<Player> editAccount(Player player) async {
    try {
      final response = await Dio().put(urlApi + 'account/' + player.email,
          data: player.toJson(),
          options: Options(contentType: Headers.formUrlEncodedContentType));

      if (kDebugMode) {
        print('response ${response.data}');
      }

      return Player.fromJson(response.data);
    } on DioError catch(e) {
      if (e.response != null) {
        throw Exception(e.response.data);
      } else {
        throw Exception(e.message);
      }
    }
  }



  //////////////////////////// AUTH /////////////////////////////////////
  signUp(String email, String password) async {
    try {
      final response = await Dio().post(urlApi + 'register',
          data: {'email': email, 'password': password},
          options: Options(contentType: Headers.formUrlEncodedContentType));

        if (kDebugMode) {
          print('response ${response.data}');
        }

        return response.data['email'];
    } on DioError catch(e) {
        // The request was made and the server responded with a status code
        // that falls out of the range of 2xx and is also not 304.
        if (e.response != null) {
          throw Exception(e.response.data);
        } else {
          // Something happened in setting up or sending the request that triggered an Error
          throw Exception(e.message);
        }
    }
  }

  signIn(String email, String password) async {
    try {
      final response = await Dio().post(urlApi + 'login',
          data: {'email': email, 'password': password},
          options: Options(contentType: Headers.formUrlEncodedContentType));

        if (kDebugMode) {
          print('response ${response.data}');
        }

        return response.data.toString().isNotEmpty ? response.data['email'] : '';
    } on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        throw Exception(e.response.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        throw Exception(e.message);
      }
    }
  }
}