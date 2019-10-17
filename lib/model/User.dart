class User {
  User({
    this.name,
    this.image,
    this.public_repos,
    this.followers,
    this.following
  });

  final String name;
  final String image;
  final int public_repos;
  final int followers;
  final int following;
}
