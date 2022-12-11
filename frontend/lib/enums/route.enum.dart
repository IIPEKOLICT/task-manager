enum RouteEnum {
  auth('/'),
  home('/home'),
  project('/project'),
  task('/task');

  final String value;

  const RouteEnum(this.value);
}
