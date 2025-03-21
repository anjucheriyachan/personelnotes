import 'package:pigeon/pigeon.dart';

class UserDetails {
  String? uid;
  String? email;
  String? name;
}

@HostApi()
abstract class UserApi {
  UserDetails signUp(String email, String password, String name);
  UserDetails login(String email, String password);
}
