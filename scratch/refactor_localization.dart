import 'dart:io';
import 'dart:convert';

void main() async {
  final dir = Directory('lib');
  final files = await dir.list(recursive: true).toList();
  
  Map<String, String> newKeys = {};
  int updatedFiles = 0;

  for (var entity in files) {
    if (entity is File && entity.path.endsWith('.dart')) {
      String content = await entity.readAsString();
      
      // Matches Text('Something') or Text("Something")
      final regExp = RegExp(r"Text\(\s*[']([^']+)[']\s*\)");
      String newContent = content.replaceAllMapped(regExp, (match) {
        String original = match.group(1)!;
        if (original.contains(r'$')) return match.group(0)!;
        if (original.trim().isEmpty) return match.group(0)!;
        
        String key = _makeKey(original);
        if (key.isEmpty) return match.group(0)!;

        newKeys[key] = original;
        return "Text('$key'.tr())";
      });

      final regExp2 = RegExp(r'Text\(\s*["]([^"]+)["]\s*\)');
      newContent = newContent.replaceAllMapped(regExp2, (match) {
        String original = match.group(1)!;
        if (original.contains(r'$')) return match.group(0)!;
        if (original.trim().isEmpty) return match.group(0)!;
        
        String key = _makeKey(original);
        if (key.isEmpty) return match.group(0)!;

        newKeys[key] = original;
        return "Text('$key'.tr())";
      });

      // Matches BasicText(text: 'Something')
      final regExp3 = RegExp(r"text:\s*[']([^']+)[']");
      newContent = newContent.replaceAllMapped(regExp3, (match) {
        String original = match.group(1)!;
        if (original.contains(r'$')) return match.group(0)!;
        if (original.trim().isEmpty) return match.group(0)!;
        if (original == 'Outfit') return match.group(0)!;
        
        String key = _makeKey(original);
        if (key.isEmpty) return match.group(0)!;

        newKeys[key] = original;
        return "text: '$key'.tr()";
      });

      // Matches title: 'Something'
      final regExp4 = RegExp(r"title:\s*[']([^']+)[']");
      newContent = newContent.replaceAllMapped(regExp4, (match) {
        String original = match.group(1)!;
        if (original.contains(r'$')) return match.group(0)!;
        if (original.trim().isEmpty) return match.group(0)!;
        
        String key = _makeKey(original);
        if (key.isEmpty) return match.group(0)!;

        newKeys[key] = original;
        return "title: '$key'.tr()";
      });

      // Matches hintText: 'Something'
      final regExp5 = RegExp(r"hintText:\s*[']([^']+)[']");
      newContent = newContent.replaceAllMapped(regExp5, (match) {
        String original = match.group(1)!;
        if (original.contains(r'$')) return match.group(0)!;
        if (original.trim().isEmpty) return match.group(0)!;
        
        String key = _makeKey(original);
        if (key.isEmpty) return match.group(0)!;

        newKeys[key] = original;
        return "hintText: '$key'.tr()";
      });

      // Matches labelText: 'Something'
      final regExp6 = RegExp(r"labelText:\s*[']([^']+)[']");
      newContent = newContent.replaceAllMapped(regExp6, (match) {
        String original = match.group(1)!;
        if (original.contains(r'$')) return match.group(0)!;
        if (original.trim().isEmpty) return match.group(0)!;
        
        String key = _makeKey(original);
        if (key.isEmpty) return match.group(0)!;

        newKeys[key] = original;
        return "labelText: '$key'.tr()";
      });

      if (content != newContent) {
        if (!newContent.contains('easy_localization.dart')) {
          newContent = "import 'package:easy_localization/easy_localization.dart';\n" + newContent;
        }
        await entity.writeAsString(newContent);
        updatedFiles++;
        print('Updated \${entity.path}');
      }
    }
  }
  
  print('Updated \$updatedFiles files.');

  // Update en.json
  final enFile = File('assets/translations/en.json');
  Map<String, dynamic> enJson = {};
  if (await enFile.exists()) {
    String jsonStr = await enFile.readAsString();
    enJson = jsonDecode(jsonStr);
  }
  
  // Merge new keys
  for (var entry in newKeys.entries) {
    if (!enJson.containsKey(entry.key)) {
      enJson[entry.key] = entry.value;
    }
  }

  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  await enFile.writeAsString(encoder.convert(enJson));
  print('Updated en.json with \${newKeys.length} new keys.');

  // Do the same for ar, de, fr with placeholders or translation
  for (String lang in ['ar', 'de', 'fr']) {
    final langFile = File('assets/translations/\$lang.json');
    Map<String, dynamic> langJson = {};
    if (await langFile.exists()) {
      String jsonStr = await langFile.readAsString();
      langJson = jsonDecode(jsonStr);
    }
    
    for (var entry in newKeys.entries) {
      if (!langJson.containsKey(entry.key)) {
        langJson[entry.key] = "[\$lang] \${entry.value}"; // Placeholder for now
      }
    }
    await langFile.writeAsString(encoder.convert(langJson));
    print('Updated \$lang.json');
  }
}

String _makeKey(String original) {
  String key = original.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_').replaceAll(RegExp(r'_+'), '_');
  if (key.endsWith('_')) key = key.substring(0, key.length - 1);
  if (key.startsWith('_')) key = key.substring(1);
  return key;
}
