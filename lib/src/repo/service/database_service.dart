import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slinfy_crm_admin/src/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference data = FirebaseFirestore.instance.collection("Data");

  addUserData(UserModel userData) async {
    await _db.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).set(userData.toMap());
  }

  Future<List<UserModel>> retrieveUserData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("Users").get();
    return snapshot.docs
        .map((docSnapshot) => UserModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
  Future<UserModel> retrieveSingleUserData(String uid) async {
    print(uid);
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("Users").doc(uid).get();
    print(snapshot.data());
    return UserModel.fromDocumentSnapshot(snapshot);
  }

  Future<String> retrieveUserName(UserModel user) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("Users").doc(user.uid).get();
    return snapshot.data()!["displayName"];
  }

  Stream<DocumentSnapshot> getBasicData() =>   data.doc("BasicLearningData").snapshots();
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsers(String name) =>  name ==''?_db.collection("Users").snapshots(): _db.collection("Users").where('displayName',isGreaterThanOrEqualTo: name).snapshots();
  Future<void> addBatches(List batches) =>   data.doc("BasicLearningData").update({'Batches':batches});
  Future<void> addCollege(List batches) =>   data.doc("BasicLearningData").update({'Colleges':batches});
  Future<void> addTechnology(List batches) =>   data.doc("BasicLearningData").update({'Technology':batches});
  Future<void> addDurations(List batches) =>   data.doc("BasicLearningData").update({'Durations':batches});
}