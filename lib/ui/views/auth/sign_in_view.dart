import 'package:fimii/enums/view_state.dart';
import 'package:fimii/scoped_models/auth_model.dart';
import 'package:fimii/ui/views/auth/sign_up_view.dart';
import 'package:fimii/ui/views/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<AuthModel>(
        builder: (context, child, model) => Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Sign In',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 30),
                    //   child: ElevatedButton(
                    //     onPressed: () {},
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         FaIcon(FontAwesomeIcons.google),
                    //         Text('Continue with Google')
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    // Text('Or'),

                    // Email
                    TextField(
                      decoration: InputDecoration(hintText: 'Email'),
                      onChanged: (text) {
                        model.email = text;
                      },
                    ),

                    // Password
                    TextField(
                      decoration: InputDecoration(hintText: 'Password'),
                      obscureText: true,
                      onChanged: (text) {
                        model.password = text;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    ElevatedButton(
                      onPressed: () => model.signIn(context),
                      child: model.state == ViewState.busy
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text('Sign In'),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('If you do not have an account ? '),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpView()));
                          },
                          child: Text(
                            'Sign Up',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
