import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/common_widget/upcoming_workout_row.dart';
import 'package:fitness/model/workout_playlist_model.dart';
import 'package:flutter/material.dart';

class WorkoutPlaylistService extends StatelessWidget {
  final String pid;
  WorkoutPlaylistService({required this.pid});

  @override
  Widget build(BuildContext context) {
    final CollectionReference workoutPlaylistCollection =
        FirebaseFirestore.instance.collection('workoutPlaylist');

    // Fetch the document snapshot using the provided 'pid'

    return FutureBuilder<DocumentSnapshot>(
      future: workoutPlaylistCollection.doc(pid).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          WorkoutPlaylistModel workoutPlaylistItem = WorkoutPlaylistModel(
            title: data['title'],
            time: data['time'],
            image: data['image'],
          );
          return UpcomingWorkoutRow(workoutPlaylistItem: workoutPlaylistItem);
        }
        return const CircularProgressIndicator();
      }),
    );
  }
}
