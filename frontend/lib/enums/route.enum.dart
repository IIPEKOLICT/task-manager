enum RouteEnum {
  home('/'),
  login('/login'),
  register('/register');

  final String value;

  const RouteEnum(this.value);
}