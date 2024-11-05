import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_covoiturage/constants.dart';
import 'package:projet_covoiturage/utilities/global_widgets.dart';

class AuthScreens {
  static Widget buildSignInScreen(BuildContext context) {
        double screenHeight = MediaQuery.of(context).size.height;

   return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox( 
              width:double.infinity,
              height:screenHeight /2.7,
              child:Image.asset("lib/assets/ls.jpg"),
            ),
            Expanded(
              child: SignInScreen(
                providers: FirebaseUIAuth.providersFor(FirebaseAuth.instance.app),
                actions: [
                  _handleUserCreation(),
                  _handleSignIn(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildEmailVerificationScreen(BuildContext context) {
    Timer? emailCheckTimer;
    
    void checkEmailVerified() async {
      User? user = FirebaseAuth.instance.currentUser;
      await user?.reload(); 
      if (user != null && user.emailVerified) {
        emailCheckTimer?.cancel(); 
        Navigator.pushReplacementNamed(context, Constants.homeRoute);
      }
    }

    emailCheckTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      checkEmailVerified();
    });

    return WillPopScope(
      onWillPop: () async {
        emailCheckTimer?.cancel();
        return true;
      },
      child: EmailVerificationScreen(
        actions: [
          AuthCancelledAction((context) {
            FirebaseUIAuth.signOut(context: context);
            Navigator.pushReplacementNamed(context, Constants.signInRoute);
          }),
        ],
      ),
    );
  }

  static AuthStateChangeAction<UserCreated> _handleUserCreation() {
    return AuthStateChangeAction<UserCreated>((context, state) {
      Navigator.pushReplacementNamed(context, Constants.signInRoute);
      GlobalWidgets(context).showSnackBar(
        content: 'Compte créé. Veuillez vous connecter.',
        backgroundColor: Colors.green,
      );
    });
  }

  static AuthStateChangeAction<SignedIn> _handleSignIn(BuildContext context) {
    return AuthStateChangeAction<SignedIn>((context, state) {
      if (!state.user!.emailVerified) {
        Navigator.pushReplacementNamed(context, Constants.verifyEmailRoute);
      } else {
        Navigator.pushReplacementNamed(context, Constants.homeRoute);
      }
    });
  }
}