class Repository {
  Repository({
    this.fullName,
    this.image,
    this.description,
    this.language,
    this.stargazersCount,
    this.forksCount,
    this.watchersCount,
    this.openIssuesCount,
    this.htmlUrl,
    this.homePage,
    this.createdAt,
    this.updatedAt,
  });

  String fullName;
  String image;
  String description;
  String language;
  int stargazersCount;
  int forksCount;
  int watchersCount;
  int openIssuesCount;
  String htmlUrl;
  String homePage;
  DateTime createdAt;
  DateTime updatedAt;
}
