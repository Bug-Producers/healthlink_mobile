class AppValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (value.trim().length > 254) return 'Email is too long';
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!regex.hasMatch(value.trim())) return 'Please enter a valid email';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    if (value.length > 128) return 'Password is too long';
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(value);
    final hasNumber = RegExp(r'[0-9]').hasMatch(value);
    final hasSpecial = RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value);
    if (!hasUppercase) return 'Password must include an uppercase letter';
    if (!hasLowercase) return 'Password must include a lowercase letter';
    if (!hasNumber) return 'Password must include a number';
    if (!hasSpecial) return 'Password must include a special character';
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required';
    if (value.trim().length < 2) return 'Name is too short';
    if (value.trim().length > 100) return 'Name is too long';
    final regex = RegExp(r"^[a-zA-Z\s'-]+$");
    if (!regex.hasMatch(value.trim())) return 'Name contains invalid characters';
    return null;
  }

  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) return 'Confirm your password';
    if (password != confirmPassword) return 'Passwords do not match';
    return null;
  }
}