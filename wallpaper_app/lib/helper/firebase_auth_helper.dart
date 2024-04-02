import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_wallpaper_app/views/screens/home_page.dart';

import '../modal/wallpaper_modal.dart';
import '../views/screens/liked_page.dart';

class FireBaseHelper {
  FireBaseHelper._();

  static final FireBaseHelper fireBaseHelper = FireBaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  Future<User?> annoumusLogin() async {
    UserCredential userCredential = await firebaseAuth.signInAnonymously();

    return userCredential.user;
  }

  //like for wallpaper
  void wallpaperLikeStatus(BuildContext context, Wallpaper wallpaper) async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser != null) {
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
      final likedWallpapersRef =
          userRef.collection('likedWallpapers').doc(wallpaper.id.toString());

      try {
        final snapshot = await likedWallpapersRef.get();
        if (snapshot.exists) {
          final isLiked = snapshot.data()?['liked'] ?? false;
          wallpaper.isLiked = isLiked;
          if (wallpaper.isLiked) {
            await likedWallpapersRef.delete();
          } else {
            await likedWallpapersRef.set({'liked': true});
          }
        }
      } catch (error) {
        print("Error: $error");
      }
    } else {
      print("User is not authenticated.");
    }
  }

  Future<User?> loginWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    UserCredential credential = await firebaseAuth.signInWithCredential(
      GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      ),
    );
    return credential.user;
  }

  Future<void> logoutUser() async {
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
  }
}
