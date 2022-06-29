import 'package:fimii/scoped_models/account_model.dart';
import 'package:fimii/ui/views/account/new_club_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../base_view.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AccountModel>(
      onModelReady: (model) => model.onModelReady(),
        builder: (context, child, model) => Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => model.signOut(context) ,
                child: const Text('Sign\nOut'),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Avatar
                          Container(
                            width: 120,
                            height: 120,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://media.istockphoto.com/vectors/missing-image-of-a-person-placeholder-vector-id1288129985?k=20&m=1288129985&s=612x612&w=0&h=OHfZHfKj0oqIDMl5f_oRqH13MHiB63nUmySYILbWbjE='),
                                  fit: BoxFit.cover,
                                )),
                          ),

                          // Personal Info
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model?.player?.name ?? 'Anonymous',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              Text(
                                model.email,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                model?.player?.phoneNumber ?? '',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              IconButton(
                                iconSize: 16,
                                icon: const FaIcon(FontAwesomeIcons.pen),
                                onPressed: () => model.moveToEditView(context),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        'Upcoming Game',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const Text('There is no upcoming game'),
                      const SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Club',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => NewClubView()));
                            },
                            child: Row(
                              children: [
                                Text("Create new club",
                                     style: Theme.of(context).textTheme.headline2,),
                                const Icon(Icons.plus_one)
                              ],
                            ),
                          )
                        ],
                      ),
                      const Text("You don't belong to any clubs...")
                    ],
                  ),
                ),
              ),
            ));
  }
}
