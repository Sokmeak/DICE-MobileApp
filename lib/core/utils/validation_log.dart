class ValidationLog {
  // validate name
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  // validate email
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }

    return null;
  }

  // validate password with special characters
  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }

    // Password must contain at least one letter and one number and one special character
    final passwordRegex = RegExp(
        r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must contain at least one special character\n and one number';
    }
    return null;
  }
}
