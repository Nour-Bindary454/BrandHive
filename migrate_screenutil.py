import os
import re

lib_dir = "c:\\projects\\brand\\lib"

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    original_content = content
    needs_import = False

    # Remove all const before widgets that will get dynamic properties
    content = re.sub(r'const\s+(SizedBox|EdgeInsets|BorderRadius|TextStyle|Radius|Padding|Icon|BoxDecoration|Offset|Text|Column|Row|Container|DecorationImage)', r'\1', content)

    # 1. height
    content, count = re.subn(r'height:\s*(\d+(?:\.\d+)?)', r'height: \1.h', content)
    if count > 0: needs_import = True

    # 2. width
    content, count = re.subn(r'width:\s*(\d+(?:\.\d+)?)', r'width: \1.w', content)
    if count > 0: needs_import = True

    # 3. fontSize
    content, count = re.subn(r'fontSize:\s*(\d+(?:\.\d+)?)', r'fontSize: \1.sp', content)
    if count > 0: needs_import = True

    # 4. circular
    content, count = re.subn(r'circular\(\s*(\d+(?:\.\d+)?)\s*\)', r'circular(\1.r)', content)
    if count > 0: needs_import = True
    
    content, count = re.subn(r'Radius\.circular\(\s*(\d+(?:\.\d+)?)\s*\)', r'Radius.circular(\1.r)', content)

    # 5. EdgeInsets.all
    content, count = re.subn(r'EdgeInsets\.all\(\s*(\d+(?:\.\d+)?)\s*\)', r'EdgeInsets.all(\1.r)', content)
    if count > 0: needs_import = True

    # 6. vertical inside EdgeInsets
    content, count = re.subn(r'vertical:\s*(\d+(?:\.\d+)?)', r'vertical: \1.h', content)
    if count > 0: needs_import = True

    # 7. horizontal inside EdgeInsets
    content, count = re.subn(r'horizontal:\s*(\d+(?:\.\d+)?)', r'horizontal: \1.w', content)
    if count > 0: needs_import = True
    
    # 8. only inside EdgeInsets
    content, count = re.subn(r'top:\s*(\d+(?:\.\d+)?)', r'top: \1.h', content)
    content, count = re.subn(r'bottom:\s*(\d+(?:\.\d+)?)', r'bottom: \1.h', content)
    content, count = re.subn(r'left:\s*(\d+(?:\.\d+)?)', r'left: \1.w', content)
    content, count = re.subn(r'right:\s*(\d+(?:\.\d+)?)', r'right: \1.w', content)

    # Blur / Spread radius
    content, count = re.subn(r'blurRadius:\s*(\d+(?:\.\d+)?)', r'blurRadius: \1.r', content)
    content, count = re.subn(r'spreadRadius:\s*(\d+(?:\.\d+)?)', r'spreadRadius: \1.r', content)

    # size (icons)
    content, count = re.subn(r'size:\s*(\d+(?:\.\d+)?)', r'size: \1.sp', content)
    if count > 0: needs_import = True

    if content != original_content and needs_import:
        if "package:flutter_screenutil/flutter_screenutil.dart" not in content and "main.dart" not in filepath and "my_app.dart" not in filepath:
            import_statement = "import 'package:flutter_screenutil/flutter_screenutil.dart';\n"
            if "import 'package:flutter/material.dart';" in content:
                content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\n" + import_statement)
            else:
                content = import_statement + content

        # Safety cleanup for existing double extensions
        content = re.sub(r'\.h\.h', '.h', content)
        content = re.sub(r'\.w\.w', '.w', content)
        content = re.sub(r'\.sp\.sp', '.sp', content)
        content = re.sub(r'\.r\.r', '.r', content)

        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)

for root, dirs, files in os.walk(lib_dir):
    for file in files:
        if file.endswith('.dart'):
             process_file(os.path.join(root, file))

print("Migration completed.")
