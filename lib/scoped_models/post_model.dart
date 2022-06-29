import 'package:fimii/enums/view_state.dart';
import 'package:fimii/models/comment.dart';
import 'package:fimii/models/post.dart';
import 'package:fimii/scoped_models/base_model.dart';
import 'package:fimii/service_locator.dart';
import 'package:fimii/services/api.dart';
import 'package:fimii/ui/views/post/new_post_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  String error = 'Something wrong';
  String email = 'you';

  ///////////////////////////// ALL POSTS ///////////////////////////////////
  List<Post> allPosts = [];

  onModelReady() async {
    setState(ViewState.busy);
    allPosts = await apiService.fetchAllPosts().catchError((e) {
      error = e.toString();
      if (kDebugMode) {
        print(error);
      }
      setState(ViewState.error);
    });


    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');

    if (state == ViewState.error) return false;

    if (kDebugMode) {
      print(allPosts);
    }

    setState(ViewState.retrieved);

    return true;
  }

  moveToNewPostView(context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const NewPostView()));
    onModelReady();
  }

  /////////////////// DETAILED POST ////////////////////////////
  Post detailedPost = Post();
  List<Comment> comments = [];
  Comment comment = Comment();

  onLoadingDetailedPost(String id) async {
    setState(ViewState.busy);

    // Get post data
    Post post = await apiService.fetchPost(id).catchError((e) {
      error = e.toString();
      if (kDebugMode) {
        print(error);
      }
      setState(ViewState.error);
    });

    print('post - $post');

    detailedPost.assign(post);

    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');

    // Get comments for this post
    comments = await apiService.fetchComments(id).catchError((e) {
      error = e.toString();
      if (kDebugMode) {
        print(error);
      }
      setState(ViewState.error);
    });

    if (state == ViewState.error) return false;

    if (kDebugMode) {
      print(comments);
    }

    setState(ViewState.retrieved);

    return true;
  }

  addComment(String id) {
    comment.email = email;
    comment.postId = id;
    apiService.postComment(comment);

    detailedPost.commentCount = (int.tryParse(detailedPost.commentCount) + 1).toString();

    comments.add(comment);
    notifyListeners();
  }

  toggleReaction(Post post) {
    post.reactionEmails.contains(email) ? dislike(post) : like(post);
  }

  like(Post post) async {
    var result = await apiService.like(email, post).catchError((e) {
      error = e.toString();
      if (kDebugMode) {
        print(error);
      }
    });

    if (kDebugMode) {
      print(result);
    }

    post.reactionEmails += "$email, ";

    int reactionCount = int.tryParse(post.reactionCount) ?? 0;
    post.reactionCount = '${reactionCount + 1}';

    notifyListeners();
  }

  dislike(Post post) async {
    var result = await apiService.dislike(email, post).catchError((e) {
      error = e.toString();
      if (kDebugMode) {
        print(error);
      }
    });

    if (kDebugMode) {
      print(result);
    }

    post.reactionEmails = post.reactionEmails.replaceAll(email, '');

    int reactionCount = int.tryParse(post.reactionCount) ?? 0;
    post.reactionCount = '${reactionCount - 1}';

    notifyListeners();
  }

  ///////////// NEW POST ///////////////////////////
  Post newPost = Post();

  onContentChange(String text) {
    newPost.description = text;
  }

  createNewPost(context) async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');

    newPost.email = email;
    newPost.createdAt = DateFormat.yMd().add_jm().format(DateTime.now());

    setState(ViewState.busy);
    var result = await apiService.createNewPost(newPost).catchError((e) {
      error = e.toString();
      if (kDebugMode) {
        print(error);
      }
      setState(ViewState.error);
    });

    if (state == ViewState.error) return false;

    if (kDebugMode) {
      print(result);
    }

    setState(ViewState.retrieved);

    Navigator.pop(context);
  }
}