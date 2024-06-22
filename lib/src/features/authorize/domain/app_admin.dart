/// stores user Id and if user is anonymous (not registered with email)
class AppAdmin {
  final String uid;
  final bool isAnonymous;

  const AppAdmin({
    required this.uid,
    required this.isAnonymous,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppAdmin &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          isAnonymous == other.isAnonymous);

  @override
  int get hashCode => uid.hashCode ^ isAnonymous.hashCode;
}
