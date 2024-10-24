import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wheather_app/models/user.dart';

class UserProvider extends ChangeNotifier {

    AppUser? _user ;

    AppUser? get user => _user ;

    void setUser( AppUser user ) {
      _user = user;
      notifyListeners() ;
    }

}