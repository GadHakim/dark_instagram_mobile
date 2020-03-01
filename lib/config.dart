class Endpoint {
  static const String BASE_URL = '192.168.0.100:3000';

  //Auth
  static const String AUTH = 'auth/';
  static const String LOGIN = '$AUTH/login';
  static const String REGISTRATION = '$AUTH/registration';

  //People
  static const String PEOPLE = 'people/';
  static const String GET_SUBSCRIBERS = 'people/subscribers';

  //Post
  static const String POST = 'publication/';
  static const String ADD_POST = '$POST/';
  static const String ALL_POST = '$POST/all';
  static const String SUBSCRIBERS_POSTS = '$POST/subscribers';

  //Subscribers
  static const String SUBSCRIBERS = 'subscribers/';
  static const String SUBSCRIBE = '$SUBSCRIBERS/subscribe';
  static const String UNSUBSCRIBE = '$SUBSCRIBERS/unsubscribe';
}
