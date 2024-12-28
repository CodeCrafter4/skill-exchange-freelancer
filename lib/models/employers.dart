class Employers {
  String? name;
  String? uid;
  String? photoUrl;
  String? email;
  String? ratings;
  String? userDescription;
  String? status;

  Employers({
    this.name,
    this.uid,
    this.photoUrl,
    this.email,
    this.ratings,
    this.userDescription,
    this.status,
  });
  Employers.fromJson(Map<String, dynamic> json)
  {
    name = json["name"];
    uid = json["uid"];
    photoUrl = json["photoUrl"];
    email = json["email"];
    ratings = json["ratings"];
    userDescription = json["userDescription"];
    status = json["status"];
  }

}