import 'package:fimii/scoped_models/account_model.dart';
import 'package:fimii/ui/views/account/new_club_view.dart';
import 'package:flutter/material.dart';

import '../base_view.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AccountModel>(
        builder: (context, child, model) => Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
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
                                      'https://i.pinimg.com/564x/11/19/0e/11190ec93e892a6e8bbbc85bea332148.jpg'),
                                  fit: BoxFit.cover,
                                )),
                          ),

                          // Personal Info
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hector Bellerin',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              Text(
                                'hectorbellerin@gmail.com ✅',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
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
