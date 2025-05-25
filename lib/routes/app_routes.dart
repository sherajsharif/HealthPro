
abstract class Routes {
  Routes._();
  static const login = Paths.LOGIN;
  static const home = Paths.HOME;
  static const signUp = Paths.SIGNUP;
  static const appointment = Paths.APPOINTMENT;
  static const dashboard = Paths.DASHBOARD;
  static const overview = Paths.DASHBOARD;
  static const healthCard = Paths.HEALTHCARD;
  static const myLoans = Paths.MYLOANS;
}

abstract class Paths {
  Paths._();
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const APPOINTMENT = '/appointment';
  static const DASHBOARD = '/dashboard';
  static const OVERVIEW = '/overview';
  static const HEALTHCARD = '/healthCard';
  static const MYLOANS= '/myLoans';
}