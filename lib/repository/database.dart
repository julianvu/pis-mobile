import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pis_mobile/models/user.dart';

class Database {
  final db = Firestore.instance;

  Stream<QuerySnapshot> usersStream() {
    return db.collection("users").snapshots();
  }

  Future<void> createUser(User user) async {
    await db.collection("users").document(user.uid).setData(user.toMap());
  }

  Future<User> get user async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

    DocumentSnapshot snapshot =
        await db.collection("users").document(firebaseUser.uid).get();
    return User.fromMap(snapshot.data);
  }
}

Database db = Database();
