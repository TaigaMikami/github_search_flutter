class UrlCreate {
  static String repositoriesUrl(text, sort) {
    String url = "https://api.github.com/search/repositories?q=";
    return url + text + sort;
  }

  static String repositoryUrl(text) {
    String url = "https://api.github.com/search/repositories?q=";
    return url + text;
  }

  static String userUrl(text) {
    String url = "https://api.github.com/users/";
    return url + text;
  }
}
