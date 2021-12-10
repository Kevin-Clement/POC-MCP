import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class PocMcpFirebaseUser {
  PocMcpFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

PocMcpFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<PocMcpFirebaseUser> pocMcpFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<PocMcpFirebaseUser>((user) => currentUser = PocMcpFirebaseUser(user));
