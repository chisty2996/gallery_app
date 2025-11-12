/// App string constants for consistent strings throughout the app
class AppStrings {
  AppStrings._();

  // App Info
  static const String appName = 'Umbrella Listing';
  static const String appVersion = '1.0.0';

  // Common
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String done = 'Done';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String back = 'Back';
  static const String next = 'Next';
  static const String skip = 'Skip';
  static const String retry = 'Retry';
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String success = 'Success';

  // Authentication
  static const String login = 'Login';
  static const String register = 'Register';
  static const String logout = 'Logout';
  static const String continueAsGuest = 'Continue as Guest';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String forgotPassword = 'Forgot Password?';
  static const String dontHaveAccount = "Don't have an account?";
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String signUp = 'Sign Up';
  static const String signIn = 'Sign In';

  // Onboarding
  static const String getStarted = 'Get Started';
  static const String onboardingTitle1 = 'Welcome to Umbrella Listing';
  static const String onboardingTitle2 = 'Browse & Discover';
  static const String onboardingTitle3 = 'Buy, Sell & Trade';
  static const String onboardingDesc1 = 'Your one-stop solution for all your listing needs';
  static const String onboardingDesc2 = 'Explore thousands of listings from verified sellers';
  static const String onboardingDesc3 = 'Connect with buyers and sellers in your area';

  // Home
  static const String home = 'Home';
  static const String search = 'Search';
  static const String favorites = 'Favorites';
  static const String profile = 'Profile';
  static const String settings = 'Settings';

  // Error Messages
  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNetwork = 'No internet connection. Please check your network.';
  static const String errorServer = 'Server error. Please try again later.';
  static const String errorAuth = 'Authentication failed. Please login again.';
  static const String errorTimeout = 'Request timeout. Please try again.';

  // Validation Messages
  static const String validationEmailRequired = 'Email is required';
  static const String validationEmailInvalid = 'Please enter a valid email';
  static const String validationPasswordRequired = 'Password is required';
  static const String validationPasswordTooShort = 'Password must be at least 6 characters';
  static const String validationPasswordMismatch = 'Passwords do not match';

  // Session
  static const String sessionExpiring = 'Your session is about to expire';
  static const String sessionExpired = 'Your session has expired. Please login again.';
  static const String sessionTimeout = 'Session will expire in';
  static const String continueSession = 'Continue Session';

  // User Roles
  static const String roleGuest = 'Guest';
  static const String roleBuyer = 'Buyer';
  static const String roleSeller = 'Seller';
  static const String roleAgent = 'Agent';
  static const String roleAdmin = 'Admin';
}
