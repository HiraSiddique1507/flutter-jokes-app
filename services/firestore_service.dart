import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Firebase Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 🔹 Add joke to Firebase
  Future<void> addJoke(String text, String category) async {
    await _db.collection('jokes').add({
      'text': text,
      'category': category,
      'createdAt': Timestamp.now(),
    });
  }

  // 🔹 Get jokes from Firebase
  Stream<QuerySnapshot> getJokes() {
    return _db.collection('jokes').snapshots();
  }

  // 🔹 Delete joke from Firebase
  Future<void> deleteJoke(String docId) async {
    await _db.collection('jokes').doc(docId).delete();
  }
}
