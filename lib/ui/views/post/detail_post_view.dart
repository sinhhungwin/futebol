import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../base_view.dart';

class DetailPostView extends StatelessWidget {
  final String id;

  const DetailPostView({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget viewOptions(PostModel model, context) {
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount:
                      model.comments == null ? 1 : model.comments.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // Return Header
                      return Column(
                        children: [
                          Text(model.detailedPost.description),
                          const SizedBox(
                            height: 10,
                          ),
                          model.detailedPost.picture == null
                              ? Container()
                              : Image.asset(model.detailedPost.picture),
                          const SizedBox(
                            height: 10,
                          ),

                          // Like, Comment and Sharing
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Like
                              GestureDetector(
                                onTap: () =>
                                    model.toggleReaction(model.detailedPost),
                                child: Row(
                                  children: [
                                    Icon(
                                      model.detailedPost.reactionEmails
                                              .contains(model.email)
                                          ? Icons.favorite_outlined
                                          : Icons.favorite_outline,
                                      size: 25,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(model.detailedPost.reactionCount),
                                  ],
                                ),
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
                                  Text(model.detailedPost.commentCount),
                                ],
                              ),

                              // Share
                              GestureDetector(
                                onTap: () {
                                  Share.share(model.detailedPost.description ??
                                      'Check it out');
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
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Comment Text Area
                              Container(
                                width: 300,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey[600],
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: "Comment"),
                                    onChanged: (text) =>
                                        model.comment.content = text,
                                  ),
                                ),
                              ),

                              GestureDetector(
                                  onTap: () => model.addComment(id),
                                  child: const Icon(Icons.send)),
                              const SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      );
                    }

                    index -= 1;

                    String email = model.comments.elementAt(index).email;
                    String content = model.comments.elementAt(index).content;

                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.account_circle_rounded),
                        title: Text(email, style: Theme.of(context).textTheme.headline2,),
                        subtitle: Text(content),
                      ),
                    );
                  }),
            ),
          );
        case ViewState.idle:
          break;
      }

      return Container();
    }

    return BaseView<PostModel>(
        onModelReady: (model) {
          model.onLoadingDetailedPost(id);
        },
        builder: (context, child, model) => Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.account_circle_rounded),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model.email),
                        Text(
                          model?.detailedPost?.createdAt ?? '',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () {},
              //   child: const Icon(Icons.plus_one),
              // ),
              body: viewOptions(model, context),
            ));
  }
}
