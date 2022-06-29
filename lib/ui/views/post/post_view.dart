import 'package:fimii/enums/view_state.dart';
import 'package:fimii/models/post.dart';
import 'package:fimii/scoped_models/post_model.dart';
import 'package:fimii/ui/views/post/detail_post_view.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../base_view.dart';

class PostView extends StatelessWidget {
  const PostView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<PostModel>(
        onModelReady: (model) => model.onModelReady(),
        builder: (context, child, model) => Scaffold(
              body: viewOptions(model, context),
            ));
  }

  Widget viewOptions(PostModel model, context) {
    Widget postWidget(Post post) => GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailPostView(id: post.id)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Post metadata
              Row(
                children: [
                  // Avatar
                  const Icon(
                    Icons.account_circle,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Text(post.email),

                        // Time
                        Text(post.createdAt)
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 12,
              ),

              // Post text
               Text(post.description),

              const SizedBox(
                height: 12,
              ),

              // Team image
              post?.picture == null ? Container(): Image.network(post.picture),

              const SizedBox(
                height: 12,
              ),

              // Like, Comment and Sharing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Like
                  Row(
                    children: [
                       GestureDetector(
                         onTap: () => model.toggleReaction(post),
                         child: Icon(
                          post.reactionEmails.contains(model.email) ?
                          Icons.favorite_outlined : Icons.favorite_outline,
                          size: 25,
                          color: Colors.red,
                      ),
                       ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(post?.reactionCount ?? "0"),
                    ],
                  ),

                  // Comments
                  Row(
                    children: [
                      const Icon(
                        Icons.web,
                        size: 25,
                        color: Colors.lightBlueAccent,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(post?.commentCount ?? "0"),
                    ],
                  ),

                  // Share
                  GestureDetector(
                    onTap: () {
                      Share.share(post.description ?? 'Check it out');
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.share,
                          size: 25,
                          color: Colors.lightBlue,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text("Share"),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

    switch (model.state) {
      case ViewState.busy:
        return const Center(child: CircularProgressIndicator());

      case ViewState.error:
        return Text(
          model.error.toString(),
          style: const TextStyle(color: Colors.red),
        );

      case ViewState.retrieved:
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  SizedBox(
                    height: 50,
                    child: Image.asset('assets/img/logo-removebg.png'),
                  ),

                  // To create a new post
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://media.istockphoto.com/vectors/missing-image-of-a-person-placeholder-vector-id1288129985?k=20&m=1288129985&s=612x612&w=0&h=OHfZHfKj0oqIDMl5f_oRqH13MHiB63nUmySYILbWbjE='),
                              fit: BoxFit.cover,
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 300,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[600],
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GestureDetector(
                          onTap: () => model.moveToNewPostView(context),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "Hey ${model.email}, tell the world what you're thinking..."),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...model.allPosts.map((e) => postWidget(e))
                ],
              ),
            ),
          ),
        );
      default:
        return Container();
    }
  }
}
