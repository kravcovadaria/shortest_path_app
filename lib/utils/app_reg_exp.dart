abstract class AppRegExp {
  static const _url =
      r'(https:\/\/www\.|http:\/\/www\.|https:\/\/|http:\/\/)(www\.)?([\w\-%].){2,}([\/]?[\w\-%]){1,}((\?|&)([\w=]+)([\w]+)){0,}';

  static final url = RegExp(_url, unicode: true);
}
