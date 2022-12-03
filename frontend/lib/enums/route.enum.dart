enum RouteEnum {
  auth('/'),
  home('/home'),
  login('/login'),
  register('/register'),
  projects('/projects');

  final String value;

  const RouteEnum(this.value);
}
