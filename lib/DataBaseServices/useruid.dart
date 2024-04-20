class AuthService {
  static String? _uid;

  static void setUID(String uid) {
    _uid = uid;
  }

  static String? getUID() {
    return _uid;
  }
}
