class Repository {
  Repository(
    {
      this.full_name,
      this.image,
      this.description,
      this.language,
      this.stargazers_count,
      this.forks_count,
      this.watchers_count,
      this.open_issues_count,
      this.html_url,
      this.home_page,
      this.created_at,
      this.updated_at,
    });

  final String full_name;
  final String image;
  final String description;
  final String language;
  final int stargazers_count;
  final int forks_count;
  final int watchers_count;
  final int open_issues_count;
  final String html_url;
  final String home_page;
  final DateTime created_at;
  final DateTime updated_at;
}
