import 'package:fitness/model/workout_playlist_model.dart';
import 'package:fitness/service/workout_playlist.dart';
import 'package:get/get.dart';

class WorkoutPlaylistController extends GetxController {
  static WorkoutPlaylistController get to => Get.find();
  final isLoading = false.obs;
  final _workoutPlaylistService = Get.put(WorkoutPlaylistService());
  RxList<WorkoutPlaylistModel> allWorkoutPlaylist =
      <WorkoutPlaylistModel>[].obs;

  RxList<WorkoutPlaylistModel> featuredWorkoutPlaylist =
      <WorkoutPlaylistModel>[].obs;

  @override
  void onInit() {
    fetchWorkoutPlaylist().then((value) {
      isLoading.value = false;
      super.onInit();
    });
  }

  Future<void> fetchWorkoutPlaylist() async {
    try {
      isLoading.value = true;
      final workoutPlaylist =
          await _workoutPlaylistService.getWorkoutPlaylist();
      print("bao nhieu"); // print the data
      print(workoutPlaylist);
      allWorkoutPlaylist.assignAll(workoutPlaylist);
    } catch (e) {
      print(e);
    } finally {}
  }

  Future<void> fetchFeaturedWorkoutPlaylist() async {
    try {
      isLoading.value = true;
      final workoutPlaylist =
          await _workoutPlaylistService.getWorkoutPlaylist();
      featuredWorkoutPlaylist.assignAll(workoutPlaylist
          .where((element) => element.isFeatured)
          .take(3)
          .toList());
      print('hihi');
      print(featuredWorkoutPlaylist);
    } catch (e) {
      print(e);
    } finally {}
  }
}
