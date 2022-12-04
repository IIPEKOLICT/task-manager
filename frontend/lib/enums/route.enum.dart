enum RouteEnum {
  auth('/'),
  home('/home'),
  login('/login'),
  register('/register'),
  projects('/projects'),
  tasks('/tasks');

  final String value;

  const RouteEnum(this.value);
}
