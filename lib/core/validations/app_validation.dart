class AppValidator {
  static noValidation() {
    return null;
  }

  static String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'LocaleKeys.enterYourEmail.tr()';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'LocaleKeys.enterValidEmail.tr()';
    }
    return null;
  }

  static String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'LocaleKeys.enterYourPassword.tr()';
    }
    if (value.length < 6) {
      return 'LocaleKeys.passwordAtLeast6.tr()';
    }
    return null;
  }

  static String? phoneValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'LocaleKeys.enterPhoneNumber.tr()';
    }
    // if (!RegExp(r'^\(\d{3}\) \d{3}-\d{4}$').hasMatch(value)) {
    //   return LocaleKeys.enterValidNumber.tr();
    // }
    return null;
  }

  static String? nameValidation(String? name) {
    if (name == null || name.isEmpty) {
      return 'LocaleKeys.nameRequired.tr()';
    }
    return null;
  }

  static String? addressValidation(String? address) {
    if (address == null || address.isEmpty) {
      return 'LocaleKeys.addressRequired.tr()';
    }
    return null;
  }

  static String? zipCodeValidation(String? zipCode) {
    if (zipCode == null || zipCode.isEmpty) {
      return 'LocaleKeys.zipCodeRequired.tr()';
    }
    if (!RegExp(r'^\d{5}(-\d{4})?$').hasMatch(zipCode)) {
      return 'LocaleKeys.enterValidZipCode.tr()';
    }
    return null;
  }
}
