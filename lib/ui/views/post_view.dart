import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/countries_model.dart';
import 'package:fimii/ui/views/detail_post_view.dart';
import 'package:fimii/ui/views/new_post_view.dart';
import 'package:fimii/ui/views/states_view.dart';
import 'package:flutter/material.dart';

import 'base_view.dart';

class PostView extends StatelessWidget {
  const PostView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<CountriesModel>(
        onModelReady: (model) => model.onModelReady(),
        builder: (context, child, model) => Scaffold(
              body: viewOptions(model, context),
            ));
  }

  Widget viewOptions(CountriesModel model, context) {
    Widget postWidget = GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPostView()));
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
                  const Icon(Icons.account_circle, size: 30,),
                  const SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        // Name
                        Text("Justin"),

                        // Time
                        Text("3 days ago")
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12,),

              // Post text
              const Text(
                  'FC DLKS toàn sinh viên trình độ yếu (siêu yếu), đá vì sức khỏe, không hề chân tay miệng.'),

              const SizedBox(height: 12,),

              // Team image
              Image.asset('assets/img/foo-team.jpg'),

              const SizedBox(height: 12,),

              // Like, Comment and Sharing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Like
                  Row(
                    children: const [
                      Icon(Icons.favorite, size: 25, color: Colors.red,),
                      SizedBox(width: 2,),
                      Text("4"),
                    ],
                  ),

                  // Comments
                  Row(
                    children: const [
                      Icon(Icons.web, size: 25, color: Colors.lightBlueAccent,),
                      SizedBox(width: 2,),
                      Text("2"),
                    ],
                  ),

                  // Share
                  Row(
                    children: const [
                      Icon(Icons.share, size: 25, color: Colors.lightBlue,),
                      SizedBox(width: 2,),
                      Text("Share"),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

    switch (model.state) {
      case ViewState.Busy:
        return const Center(child: CircularProgressIndicator());

      case ViewState.Error:
        return Text(
          model.error.toString(),
          style: const TextStyle(color: Colors.red),
        );

      case ViewState.Retrieved:
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Container(
                    height: 50,
                      child: Image.asset('assets/img/logo-removebg.png'),
                  ),


                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage('https://i.pinimg.com/564x/11/19/0e/11190ec93e892a6e8bbbc85bea332148.jpg'),
                            fit: BoxFit.cover,
                          )
                        ),
                      ),
                      const SizedBox(width: 10,),
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
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => NewPostView()));
                            },
                          child: const Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Text("Hey Hector, tell the world what you're thinking..."),
                          ),
                        ),
                      ),
                    ],
                  ),
                  postWidget,
                  postWidget,
                  postWidget,
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

