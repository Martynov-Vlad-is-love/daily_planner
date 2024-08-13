import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _accountId;
  String? get uid => _accountId;
  Future<User?> signUpWithEmailAndPassword(String email,
      String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _accountId = credential.user?.uid;
      return credential.user;
    }catch(error){
      print(error.toString());
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email,
      String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _accountId = credential.user?.uid;
      return credential.user;
    }catch(error){
      print(error.toString());
    }
    return null;
  }

  void signOut(){
    try{

    }catch(error){
      /// TO-DO: handle errors
    }
  }
}