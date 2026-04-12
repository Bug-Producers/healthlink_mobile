class AppValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!regex.hasMatch(value.trim())) return 'Please enter a valid email';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(value);
    final hasNumber = RegExp(r'[0-9]').hasMatch(value);
    if (!hasLetter || !hasNumber) return 'Must include letters & numbers';
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required';
    return null;
  }

  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) return 'Confirm your password';
    if (password != confirmPassword) return 'Passwords do not match';
    return null;
  }
}