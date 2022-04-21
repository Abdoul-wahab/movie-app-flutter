class AppUser {
  final String uid;

  AppUser(this.uid);
}


class UserData {
  final String uid;
  final String firstname;
  final String lastname;
  final String city;
  final String email;

  UserData({required this.uid, required this.firstname, required this.lastname, required this.city, required this.email});
}