part of '../devsdocs_reusable_tools_base.dart';

class SecurityTools {
  factory SecurityTools() => _instance ??= SecurityTools._internal();
  SecurityTools._internal();
  static SecurityTools? _instance;

  final _secureRandom = Random.secure();

  /// Always provide passphrase with minimal 4 english words containing 4 letters
  ///
  /// [separator] always contain single character, if non special character detected, it will use default separator
  String randomPassphrase({
    String separator = '-',
    int length = 4,
    bool capitalizeEachWord = false,
  }) {
    String sep = separator.length > 1 ? separator[0] : separator;
    final pattern = RegExp('[^a-zA-Z0-9]');
    if (!pattern.hasMatch(sep)) {
      sep = '-';
    }
    final count = length < 4 ? 4 : length;
    final generate = List.generate(
      count,
      (_) => _englishWords[_secureRandom.nextInt(_englishWords.length)],
    );
    return capitalizeEachWord ? generate.map((e)=> e.doCapitalizeWord).join(sep) : generate.join(sep);
  }

  /// Always provide random password with minimal 8 character
  ///
  /// If all include option set to false, it will produce default behaviour
  String randomPassword({
    int length = 8,
    bool includeUppercase = true,
    bool includeLowecase = true,
    bool includeDigits = true,
    bool includeSpecialCharacter = true,
  }) {
    final count = length < 8 ? 8 : length;

    const s = '0123456789';
    const t = r'!@#$%^&*';
    const u = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const v = 'abcdefghijklmnopqrstuvwxyz';
    const w = v + u + t + s;

    final number = includeDigits ? s : '';
    final special = includeSpecialCharacter ? t : '';
    final upperAlp = includeUppercase ? u : '';
    final lowerAlp = includeLowecase ? v : '';
    final combine = lowerAlp + upperAlp + number + special;

    final finalString = combine.isNotEmpty ? combine : w;

    return List.generate(
      count,
      (_) => finalString[_secureRandom.nextInt(finalString.length)],
    ).join();
  }

  final _uuid = const Uuid(options: {'grng': UuidUtil.cryptoRNG});

  String get uuidV4 => _uuid.v4();

  /// Will use [Uuid.NAMESPACE_URL] if [nameSpace] is not provided.
  ///
  /// If [nameSpace] is provided and invalid, will use [Uuid.NAMESPACE_URL] or random [uuidV4] based on [useRandomNameSpaceWhenInvalid] flags
  String getUuidV5(
    String stringToBeEncrypted, {
    String nameSpace = Uuid.NAMESPACE_URL,
    bool useRandomNameSpaceWhenInvalid = false,
  }) {
    final isValid = Uuid.isValidUUID(fromString: nameSpace);

    final finalNameSpace = isValid
        ? nameSpace
        : useRandomNameSpaceWhenInvalid
            ? uuidV4
            : Uuid.NAMESPACE_URL;

    return _uuid.v5(finalNameSpace, stringToBeEncrypted);
  }
}

double calculatePasswordStrength(String password) {
  final length = password.length;
  int complexity = 0;

  // Check for different character types
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasDigit = false;
  bool hasSpecialChar = false;

  for (int i = 0; i < length; i++) {
    final char = password[i];

    if (char.contains(RegExp('[a-z]'))) {
      hasLowercase = true;
    } else if (char.contains(RegExp('[A-Z]'))) {
      hasUppercase = true;
    } else if (char.contains(RegExp('[0-9]'))) {
      hasDigit = true;
    } else {
      hasSpecialChar = true;
    }
  }

  // Increment complexity for each character type present
  if (hasLowercase) complexity++;
  if (hasUppercase) complexity++;
  if (hasDigit) complexity++;
  if (hasSpecialChar) complexity++;

  // Calculate password strength
  final strength = (length / 10) * complexity / 4;

  // Ensure the strength is within the range of 0 to 1
  return strength.clamp(0, 1);
}

double estimateBruteforceStrength(String password) {
  if (password.isEmpty) return 0.0;

  // Check which types of characters are used and create an opinionated bonus.
  double charsetBonus;
  if (RegExp(r'^[0-9]*$').hasMatch(password)) {
    charsetBonus = 0.8;
  } else if (RegExp(r'^[a-z]*$').hasMatch(password)) {
    charsetBonus = 1.0;
  } else if (RegExp(r'^[a-z0-9]*$').hasMatch(password)) {
    charsetBonus = 1.2;
  } else if (RegExp(r'^[a-zA-Z]*$').hasMatch(password)) {
    charsetBonus = 1.3;
  } else if (RegExp(r'^[a-z\-_!?]*$').hasMatch(password)) {
    charsetBonus = 1.3;
  } else if (RegExp(r'^[a-zA-Z0-9]*$').hasMatch(password)) {
    charsetBonus = 1.5;
  } else {
    charsetBonus = 1.8;
  }

  double logisticFunction(double x) {
    return 1.0 / (1.0 + exp(-x));
  }

  double curve(double x) {
    return logisticFunction((x / 3.0) - 4.0);
  }

  return curve(password.length * charsetBonus);
}

double calculateEffectivePasswordStrength(String password) {
  final bruteforceStrength = estimateBruteforceStrength(password);
  final complexityStrength = calculatePasswordStrength(password);

  // Weighted average of bruteforce strength and complexity strength
  final effectiveStrength = (bruteforceStrength + complexityStrength) / 2;

  return effectiveStrength;
}
