import 'dart:io';

void main() async {
  final dir = Directory('lib');
  final files = await dir.list(recursive: true).toList();
  int updatedFiles = 0;

  for (var entity in files) {
    if (entity is File && entity.path.endsWith('.dart')) {
      // Exclude my_app.dart because it defines the theme
      if (entity.path.endsWith('my_app.dart')) continue;
      // Exclude basic_colors.dart
      if (entity.path.endsWith('basic_colors.dart')) continue;

      String content = await entity.readAsString();
      String newContent = content;

      // Safe replacements for text colors (often BasicColors.black or Colors.black in TextStyle)
      newContent = newContent.replaceAll(
          RegExp(r'color:\s*BasicColors\.black'), 
          'color: Theme.of(context).textTheme.bodyLarge?.color');
          
      // Replacing color: Colors.black in TextStyle or similar
      newContent = newContent.replaceAll(
          RegExp(r'color:\s*Colors\.black'), 
          'color: Theme.of(context).textTheme.bodyLarge?.color');

      // Safe replacements for backgrounds (BasicColors.white -> cardColor)
      newContent = newContent.replaceAll(
          RegExp(r'color:\s*BasicColors\.white'), 
          'color: Theme.of(context).cardColor');

      // We will skip replacing Colors.white blindly to avoid ruining button texts.
      // But we can replace it in BoxDecoration
      newContent = newContent.replaceAllMapped(
        RegExp(r'BoxDecoration\s*\(([^)]*)color:\s*Colors\.white'), 
        (match) => 'BoxDecoration(${match.group(1)}color: Theme.of(context).cardColor'
      );

      // Replace scaffold background color if it was explicitly set
      newContent = newContent.replaceAll(
        RegExp(r'backgroundColor:\s*Colors\.white'), 
        'backgroundColor: Theme.of(context).scaffoldBackgroundColor'
      );
      newContent = newContent.replaceAll(
        RegExp(r'backgroundColor:\s*BasicColors\.white'), 
        'backgroundColor: Theme.of(context).scaffoldBackgroundColor'
      );

      // BasicColors.grey is often used for subtitles
      newContent = newContent.replaceAll(
          RegExp(r'color:\s*BasicColors\.grey'), 
          'color: Theme.of(context).textTheme.bodyMedium?.color');

      if (content != newContent) {
        await entity.writeAsString(newContent);
        updatedFiles++;
        print('Updated \${entity.path}');
      }
    }
  }
  
  print('Updated \$updatedFiles files for Theme colors.');
}
