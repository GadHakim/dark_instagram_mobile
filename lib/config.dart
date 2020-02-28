class Internet {
  static const String BASE_URL = 'http://192.168.0.100:3000';

  static const String AUTH = BASE_URL + '/auth';
  static const String SIGN_IN = AUTH + '/login';
  static const String SIGN_UP = AUTH + '/registration';

  static const String PEOPLE = BASE_URL + '/people';
  static const String GET_PEOPLE = PEOPLE;
}
