/// stores user Id and if user is anonymous (not registered with email)
class AppUser {
  AppUser({required this.uid, required this.isAnonymous});

  final String uid;
  final bool isAnonymous;
}
