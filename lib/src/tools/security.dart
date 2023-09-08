part of '../reusable_tools_base.dart';

class SecurityTools {
  factory SecurityTools() => _instance ??= SecurityTools._internal();
  SecurityTools._internal()
      : _englishWords = EnglishWords300k.words,
        _englishWordsLength = EnglishWords300k.words.length;
  static SecurityTools? _instance;

  final List<String> _englishWords;

  final int _englishWordsLength;

  /// Always provide passphrase with minimal 4 and maximal 50 english words containing 4 letters or more
  ///
  /// [separator] always contain single character, if non special character detected, it will use default separator
  ///
  /// The passphrase words produced is never repeated.
  String generatePassphrase({
    String separator = '-',
    int length = 4,
    bool capitalizeEachWord = false,
    bool useNumberSuffix = false,
    bool useSpecialCharacterSuffix = false,
  }) {
    String sep = separator.length > 1 ? separator[0] : separator;
    final pattern = RegExp('[^a-zA-Z0-9]');
    if (!pattern.hasMatch(sep)) {
      sep = '-';
    }
    final count = max(min(length, 50), 4);

    Iterable<String> uniquePhrase;

    uniquePhrase = _generateUniqueIndex(count).map((e) => _englishWords[e]);

    if (useNumberSuffix) {
      uniquePhrase = uniquePhrase.map((e) => [e, _number.getRandomItem].join());
    }
    if (useSpecialCharacterSuffix) {
      uniquePhrase =
          uniquePhrase.map((e) => [e, _specialChar.getRandomItem].join());
    }
    if (capitalizeEachWord) {
      uniquePhrase = uniquePhrase.map((e) => e.capitalizeWord);
    }

    return uniquePhrase.join(sep);
  }

  List<int> _generateUniqueIndex(int count) {
    final generate = List.generate(
      count,
      (_) => _englishWordsLength.getRandomNumberFromZeroToLessThanThis,
    );
    final set = generate.toSet();
    if (set.length == count) {
      return generate;
    }
    return _generateUniqueIndex(count);
  }

  final _number = '0123456789';
  final _specialChar = r'!@#$%^&*';
  final _uppercaseAlp = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final _lowercaseAlp = 'abcdefghijklmnopqrstuvwxyz';

  /// Always provide random password with minimal 8 and maximal 100 character
  ///
  /// If all include option set to false, it will produce default behaviour (all include flags is true)
  String generatePassword({
    int length = 8,
    bool includeUppercase = true,
    bool includeLowercase = true,
    bool includeDigits = true,
    bool includeSpecialCharacter = true,
  }) {
    bool uppercase = includeUppercase;
    bool lowercase = includeLowercase;
    bool digits = includeDigits;
    bool specialCharacter = includeSpecialCharacter;

    // Check if all include flags are false
    if (!includeUppercase &&
        !includeLowercase &&
        !includeDigits &&
        !includeSpecialCharacter) {
      uppercase = true;
      lowercase = true;
      digits = true;
      specialCharacter = true;
    }

    final passwordCharacters = <String>[];

    final effectiveLength = max(min(length, 100), 8);

    if (uppercase) {
      passwordCharacters.add(_uppercaseAlp.getRandomItem);
    }

    if (lowercase) {
      passwordCharacters.add(_lowercaseAlp.getRandomItem);
    }

    if (digits) {
      passwordCharacters.add(_number.getRandomItem);
    }

    if (specialCharacter) {
      passwordCharacters.add(_specialChar.getRandomItem);
    }

    final remainingCharacters = (digits ? _number : '') +
        (specialCharacter ? _specialChar : '') +
        (uppercase ? _uppercaseAlp : '') +
        (lowercase ? _lowercaseAlp : '');

    for (int i = passwordCharacters.length; i < effectiveLength; i++) {
      passwordCharacters.add(remainingCharacters.getRandomItem);
    }

    passwordCharacters.shuffle(Random.secure());
    return passwordCharacters.join();
  }

  final _uuid = Uuid(goptions: GlobalOptions(CryptoRNG()));

  String get getUuidV1 => _uuid.v1();
  String get getUuidV4 => _uuid.v4();

  /// Will use [Uuid.NAMESPACE_URL] if [nameSpace] is not provided.
  ///
  /// If [nameSpace] is provided and invalid, will use [Uuid.NAMESPACE_URL] or random [getUuidV4] based on [useRandomNameSpaceWhenInvalid] flags
  String getUuidV5(
    String stringToBeEncrypted, {
    String nameSpace = Uuid.NAMESPACE_URL,
    bool useRandomNameSpaceWhenInvalid = false,
  }) {
    final isValid = Uuid.isValidUUID(fromString: nameSpace);

    final finalNameSpace = isValid
        ? nameSpace
        : useRandomNameSpaceWhenInvalid
            ? getUuidV4
            : Uuid.NAMESPACE_URL;

    return _uuid.v5(finalNameSpace, stringToBeEncrypted);
  }

  /// The closest the result to 1, the better
  num checkPasswordStrength(String password) {
    final bruteforceStrength = _estimateBruteforceStrength(password);
    final complexityStrength = _calculatePasswordStrength(password);

    // Weighted average of bruteforce strength and complexity strength
    final effectiveStrength = (bruteforceStrength + complexityStrength) / 2;

    return effectiveStrength.toIntIfTrue;
  }
}

double _calculatePasswordStrength(String password) {
  final length = password.length;
  int complexity = 0;

  // Check for different character types
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasDigit = false;
  bool hasSpecialChar = false;

  for (int i = 0; i < length; i++) {
    if (hasSpecialChar && hasDigit && hasLowercase && hasUppercase) break;
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

double _estimateBruteforceStrength(String password) {
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

  return _curve(password.length * charsetBonus);
}

double _logisticFunction(double x) => 1.0 / (1.0 + exp(-x));

double _curve(double x) => _logisticFunction((x / 3.0) - 4.0);
