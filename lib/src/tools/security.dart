part of '../devsdocs_reusable_tools_base.dart';

class SecurityTools {
  factory SecurityTools() => _instance ??= SecurityTools._internal();
  SecurityTools._internal();
  static SecurityTools? _instance;

  final _secureRandom = Random.secure();

  String randomPassphrase({
    String separator = '-',
    int length = 4,
    bool includeNumber = false,
  }) {
    final count = length < 4 ? 4 : length;
    final generate = List.generate(
      count,
      (_) => englishWords[_secureRandom.nextInt(englishWords.length)],
    );
    return generate.join(separator);
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
    final w = (v + u + t + s).split('')..shuffle(_secureRandom);

    final number = includeDigits ? s : '';
    final special = includeSpecialCharacter ? t : '';
    final upperAlp = includeUppercase ? u : '';
    final lowerAlp = includeLowecase ? v : '';
    final combine = (lowerAlp + upperAlp + number + special).split('')
      ..shuffle(_secureRandom);

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
