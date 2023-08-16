# Personal Reusable Tools
## Feel free to fork and/or modify! (For your lazy mode)
All extension have Async version if supported.

### Extension dart:core
- Map
  - toJsonString: Convert to JSON String
- List
  - toJsonString: Convert to JSON String
- String
  - toJsonObject: Convert to JSON Object
### Extension dart:io
- File
  - getSha256: SHA256 of file
  - getSha1: SHA1 of file
  - getMd5: MD5 of file
  - getBase64: Base64 of file
- Directory
  - check: check if exist, if not then create

### If neccesary, only import what you need
```dart
import 'package:devsdocs_reusable_tools/devsdocs_reusable_tools.dart' show SecurityTools;
```

DoExtension: Add a method do to perform an action on the object.

GetExtension: Add a method get to retrieve a value from the object.

ToExtension: Add a method to to convert the object to a specific type.

MapExtension: Add a method map to transform the object's data using a function.

RunExtension: Add a method run to execute an operation using the object.

SetExtension: Add a method set to modify the object's properties.

WithExtension: Add a method with to combine the object with another.

IsExtension: Check