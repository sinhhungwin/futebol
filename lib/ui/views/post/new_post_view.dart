import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/post_model.dart';
import 'package:fimii/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class NewPostView extends StatelessWidget {
  const NewPostView({Key key}) : super(key: key);

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
              child: Column(
                children: [
                  Expanded(
                      child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                        hintText: 'Post to find opponent, find a slot to play'),
                    style: Theme.of(context).textTheme.subtitle2,
                    onChanged: model.onContentChange,
                  )),
                  const Divider(),
                  Row(
                    children: const [
                      Icon(Icons.photo_library),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.camera_alt)
                    ],
                  )
                ],
              ),
            ),
          );
        case ViewState.idle:
          break;
      }

      return Container();
    }

    return BaseView<PostModel>(
        onModelReady: (model) {
          model.onModelReady();
        },
        builder: (context, child, model) => Scaffold(
              appBar: AppBar(
                title: const Text('Create new post'),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => model.createNewPost(context),
                child: const Icon(Icons.post_add),
              ),
              body: viewOptions(model, context),
            ));
  }
}
