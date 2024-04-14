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
    fetchWorkoutPlaylist();
    super.onInit();
  }

  Future<void> fetchWorkoutPlaylist() async {
    try {
      isLoading.value = true;
      final workoutPlaylist =
          await _workoutPlaylistService.getWorkoutPlaylist();
      /*  print(workoutPlaylist); */

      allWorkoutPlaylist.assignAll(workoutPlaylist);
     /*  print(allWorkoutPlaylist.length);
      allWorkoutPlaylist.forEach((element) => {
            print(element.title),
            print(element.image),
          }); */
/*       print(allWorkoutPlaylist);
 */ /* featuredWorkoutPlaylist.assignAll(workoutPlaylist
          .where((element) => element.isFeatured && element.parentId.isEmpty)
          .take(3)
          .toList()); */
/*       print(featuredWorkoutPlaylist);
 */
    } catch (e) {
      print(e);
    } finally {}
  }
}
