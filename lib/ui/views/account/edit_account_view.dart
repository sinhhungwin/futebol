import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/account_model.dart';
import 'package:fimii/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class EditAccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<AccountModel>(
        onModelReady: (model) => model.onModelReady(),
        builder: (context, child, model) {
          switch(model.state) {
            case ViewState.busy:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            case ViewState.retrieved:
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Edit Profile'),
                ),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // Fields
                        Expanded(child: Column(
                          children: [
                            // Email
                            TextField(
                              controller: TextEditingController()..text = model?.player?.email ?? '',
                              onChanged: (text) => {model.player.email = text},
                            ),

                            // Password
                            TextField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                  hintText: 'Password'
                              ),
                              onChanged: model.onPasswordChange,
                            ),

                            // Name
                            TextField(
                              decoration: const InputDecoration(
                                  hintText: 'Name'
                              ),
                              controller: TextEditingController()..text = model?.player?.name ?? '',
                              onChanged: (text) => {model.player.name = text},
                            ),

                            // Phone Number
                            TextField(
                              decoration: const InputDecoration(
                                  hintText: 'Phone Number'
                              ),
                              controller: TextEditingController()..text = model?.player?.phoneNumber ?? '',
                              onChanged: (text) => {model.player.phoneNumber = text},
                            ),
                          ],
                        ),),

                        // Submit
                        ElevatedButton(onPressed: () => model.editProfile(context), child: const Text('Apply'))
                      ],
                    ),
                  ),
                ),
              );

            case ViewState.error:

            default:
              return const Scaffold();
          }
        });
  }
}
