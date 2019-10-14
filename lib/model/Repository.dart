class Repository {
  Repository(
    {this.full_name, this.image, this.stargazers_count, this.forks, this.html_url});

  final String full_name;
  final String image;
  final int stargazers_count;
  final int forks;
  final String html_url;
}
