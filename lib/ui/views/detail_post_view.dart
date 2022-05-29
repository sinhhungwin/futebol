import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/your_aqi_model.dart';
import 'package:fimii/ui/views/detail_matching_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:latlong/latlong.dart" as latLng;

import 'base_view.dart';

class DetailPostView extends StatelessWidget {
  final f = DateFormat('EEEE dd,MMM', "en_US");

  String city, state, country;
  latLng.LatLng coordinates;

  DetailPostView({Key key, this.city, this.state, this.country, this.coordinates})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget viewOptions(YourAqiModel model, context) {
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children:  [
                          const Text('''Em cần tìm 1 sân 5 người đá cố định vào khoảng 18h30, thứ 3 hàng tuần (đá cố định) khu vực quận Tân Phú hoặc Quận 11. Anh/Chị nào có sân giới thiệu giúp em ạ. Em cảm ơn. Liên hệ: 0906963995 - em Hải'''),
                          const SizedBox(height: 10,),
                          Image.asset('assets/img/foo-team.jpg'),
                          const SizedBox(height: 10,),

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
                  Column(
                    children: [
                      const SizedBox(height: 15,),
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
                            child: GestureDetector(
                              onTap: () {
                              },
                              child: const Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: Text("Comment"),
                              ),
                            ),
                          ),

                          const Icon(Icons.send),
                          const SizedBox(width: 5,),
                        ],
                      ),
                      const SizedBox(height: 5,),
                    ],
                  )
                ],
              ),
            ),
          );
        case ViewState.Idle:
        // TODO: Handle this case.
          break;
      }

      return Container();
    }


    return BaseView<YourAqiModel>(
        onModelReady: (model) {
          model.onModelReady(city, state, country, coordinates);
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
                    const Text('0906963995'),
                    Text('3 days ago', style: Theme.of(context).textTheme.subtitle2,),
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
