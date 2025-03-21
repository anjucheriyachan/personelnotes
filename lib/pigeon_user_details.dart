import 'package:pigeon/pigeon.dart';

class PigeonUserDetails {
  String? uid;
  String? email;
  String? name;
}

@HostApi()
abstract class UserApi {
  Future<PigeonUserDetails?> signUp(String email, String password, String name);
  Future<PigeonUserDetails?> login(String email, String password);
}
