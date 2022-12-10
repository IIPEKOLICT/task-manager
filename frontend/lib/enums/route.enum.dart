enum RouteEnum {
  auth('/'),
  home('/home'),
  login('/login'),
  register('/register'),
  project('/project'),
  task('/task');

  final String value;

  const RouteEnum(this.value);
}
