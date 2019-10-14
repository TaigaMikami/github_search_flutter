class UrlCreate {
  static String repositoryUrl(text, sort) {
    String url = "https://api.github.com/search/repositories?q=";
    return url + text + sort;
  }
}
