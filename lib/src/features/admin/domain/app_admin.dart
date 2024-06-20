/// stores user Id and if user is anonymous (not registered with email)
class AppAdmin {
  AppAdmin({required this.uid, required this.isAnonymous});

  final String uid;
  final bool isAnonymous;
}
