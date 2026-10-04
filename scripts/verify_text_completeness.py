#!/usr/bin/env python3
import os
import re

for i in range(1, 9):
    tex_path = f'chapters/ch0{i}_' + [f for f in os.listdir('chapters') if f.startswith(f'ch0{i}')][0].split('_', 1)[1]
    typ_path = f'typst_chapters/ch0{i}_' + [f for f in os.listdir('typst_chapters') if f.startswith(f'ch0{i}')][0].split('_', 1)[1]
    
    with open(tex_path, 'r', encoding='utf-8') as f:
        tex_lines = f.readlines()
    with open(typ_path, 'r', encoding='utf-8') as f:
        typ_text = f.read()
        
    missing = []
    for line in tex_lines:
        s = line.strip()
        if not s or s.startswith('%') or s.startswith(r'\begin') or s.startswith(r'\end') or s.startswith(r'\item') or s.startswith(r'\chapter') or s.startswith(r'\section') or s.startswith(r'\subsection') or s.startswith(r'\subsubsection') or s.startswith(r'\label'):
            continue
        # Extract a distinctive sequence of words
        words = re.findall(r'[A-Za-z]{4,}', s)
        if len(words) >= 4:
            phrase = ' '.join(words[:4])
            # Check if this phrase (or words) appear in typ_text
            pattern = r'\b' + r'\b[\s\S]{0,20}\b'.join(re.escape(w) for w in words[:4]) + r'\b'
            if not re.search(pattern, typ_text, re.IGNORECASE):
                missing.append(s)
                
    if missing:
        print(f"Chapter {i} missing {len(missing)} text snippets:")
        for m in missing:
            print(f"  Snippet: {m[:80]}")
    else:
        print(f"Chapter {i}: 100% text snippet coverage!")
