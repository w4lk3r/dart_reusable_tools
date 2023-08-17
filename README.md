# Personal Reusable Tools
## Feel free to fork and/or modify! (For your lazy mode)
All extension have Async version if supported.

### Extension of `dart:core`
- Map
  - (String,dynamic => String) `toJsonString`: Convert to JSON String

- List
  - (dynamic => String) `toJsonString`: Convert to JSON String
  - (String => String) `joinPath`: Join list with current platform separator character as separator
  - (String => String) `joinComma`: Join list with comma (,) character as separator
  - (String => String) `joinDot`: Join list with dot (.) character as separator
  - (String => String) `joinSpace`: Join list with a single space character as separator

- String
  - (=> dynamic) `toJsonObject`: Convert to JSON Object

- double
  - (=> num) `toIntIfTrue`: Returning an int if double evenly divisible by 1
  - (=> double) `toPrecision(...)`: Returning double value with precision digit(s) up to given value

- int
  - (=> String) `bytesToBinaryPrefix`: Convert bytes unit in integer to human readable value in Binary Prefix standart
  - (=> String) `bytesToSIUnit`: Convert bytes unit in integer to human readable value in SI standart

### Extension of `dart:io`
- File
  - (=> String) `toSha256`: SHA256 of file
  - (=> String) `toSha1`: SHA1 of file
  - (=> String) `toMd5`: MD5 of file
  - (=> String) `toBase64`: Base64 of file
- Directory
  - (=> Direcory) `doCheck`: check if exist, if not then create

### Tools
- `SecurityTools` class
  - Object (=> double) `checkPasswordStrength(...)`: Check password strength in double, 0 to 1.
  - Object (=> String) `generatePassphrase(...)`: Generate english words passphrase.
  - Object (=> String) `generatePassword(...)`: Generate password.
  - Object (=> String) `getUuidV5(...)`: Get Uuid V5
  - Object (=> String) `getUuidV4` (getter): Get Uuid V4
  - Object (=> String) `getUuidV1` (getter): Get Uuid V1

- `NetworkTools` class
  - Static (=> _LogConfig()) `logConfig` (getter/setter): Network client logger
  - Static (=> _HttpClient()) `client` (getter): Network client

### If neccesary, only import what you need
```dart
import 'package:reusable_tools/reusable_tools.dart' show SecurityTools;
```