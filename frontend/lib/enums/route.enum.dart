enum RouteEnum {
  auth('/'),
  home('/home'),
  login('/login'),
  register('/register'),
  project('/project');

  final String value;

  const RouteEnum(this.value);
}
