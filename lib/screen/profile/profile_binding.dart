import 'package:get/get.dart';
import 'package:pecunia/screen/profile/profile_controller.dart';

class ProfileBinding implements Binding {
  @override
  List<Bind> dependencies() => [
        Bind.put(ProfileController()),
      ];
}
