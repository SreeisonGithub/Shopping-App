import 'package:flutter/widgets.dart';
import 'package:funcart/services/authentication_service.dart';

class UserProvider with ChangeNotifier {
  var _user;
  //AuthMethods _authMethods = AuthMethods();
  var auth = AuthenticationService();
  bool _isBookmarked = false;
  bool _isNoteAdded = false;

  get getUser => _user;
  bool get isBookmarked => _isBookmarked;
  bool get isNoteAdded => _isNoteAdded;

  // Future<void> fetchisNoteAdded(Songs songs) async {
  //   _isNoteAdded = await _authMethods.noteAlreadyAdded(songs.id, _user.userId);
  //   notifyListeners();
  // }

  // Future<void> fetchisBookmarked(Songs songs) async {
  //   _isBookmarked = await _authMethods.checkBookmarked(songs.id, _user.userId);
  //   notifyListeners();
  // }

  void refreshUser() {
    var user =  auth.getCurrentFirebaseUser();
    _user = user;
    notifyListeners();
  }

  signOutUser() {
    _user = null;
    notifyListeners();
  }
}
