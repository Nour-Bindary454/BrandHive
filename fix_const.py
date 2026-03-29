import os
import re

files_to_fix = [
  (r"lib\core\sharedWidgets\basic_text_field.dart", 53),
  (r"lib\features\brand_profile\presentation\views\brand_profile_screen.dart", 137),
  (r"lib\features\brand_profile\presentation\widgets\brand_header_section.dart", 126),
  (r"lib\features\home\presentation\views\widgets\action_buttons_section.dart", 44),
  (r"lib\features\home\presentation\views\widgets\promotional_banner.dart", 82),
  (r"lib\features\home\presentation\views\widgets\recommended_for_you_section.dart", 25),
  (r"lib\features\home\presentation\views\widgets\recommended_for_you_section.dart", 26),
  (r"lib\features\home\presentation\views\widgets\recommended_for_you_section.dart", 30),
  (r"lib\features\home\presentation\views\widgets\recommended_for_you_section.dart", 185),
  (r"lib\features\welcome\presentation\views\welcome.dart", 57),
]

for file_path, line_num in files_to_fix:
    full_path = "c:\\projects\\brand\\" + file_path
    with open(full_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    idx = line_num - 1
    # remove const keyword in the vicinity
    for i in range(idx, max(-1, idx - 5), -1):
        if 'const ' in lines[i]:
            # Avoid removing 'const ' if it's immediately followed by a type that we know has no ScreenUtil like String 
            # Or just remove the LAST occurrence of const.
            # Using rfind to only remove the right-most const.
            last_const = lines[i].rfind('const ')
            if last_const != -1:
                lines[i] = lines[i][:last_const] + lines[i][last_const+6:]
                break
            
    with open(full_path, 'w', encoding='utf-8') as f:
        f.writelines(lines)
