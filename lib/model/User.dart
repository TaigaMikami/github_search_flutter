class User {
  User({
    this.name,
    this.image,
    this.publicRepos,
    this.followers,
    this.following,
    this.htmlUrl,
  });

  final String name;
  final String image;
  final int publicRepos;
  final int followers;
  final int following;
  final String htmlUrl;
}
