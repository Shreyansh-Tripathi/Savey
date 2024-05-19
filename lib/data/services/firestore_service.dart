import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:savey/data/model/goal.dart';

// ignore: constant_identifier_names
const GOAL_COLLECTION_REF = 'goals';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _goalCollection;

  FirestoreService() {
    _goalCollection =
        _firestore.collection(GOAL_COLLECTION_REF).withConverter<Goal>(
              fromFirestore: (snapshots, _) => Goal.fromJson(snapshots.data()!),
              toFirestore: (goal, _) => goal.toJson(),
            );
  }

  Stream<QuerySnapshot> getGoals() {
    return _goalCollection.snapshots();
  }

  void addGoals(Goal goal) async {
    await _goalCollection.add(goal);
  }
}
