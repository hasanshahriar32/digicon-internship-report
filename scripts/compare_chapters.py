#!/usr/bin/env python3
import os
import re

tex_dir = 'chapters'
typ_dir = 'typst_chapters'

for i in range(1, 9):
    tex_files = [f for f in os.listdir(tex_dir) if f.startswith(f'ch0{i}') and f.endswith('.tex')]
    typ_files = [f for f in os.listdir(typ_dir) if f.startswith(f'ch0{i}') and f.endswith('.typ')]
    if not tex_files or not typ_files:
        print(f'Missing files for chapter {i}!')
        continue
    tex_path = os.path.join(tex_dir, tex_files[0])
    typ_path = os.path.join(typ_dir, typ_files[0])
    
    with open(tex_path, 'r', encoding='utf-8') as f:
        tex_text = f.read()
    with open(typ_path, 'r', encoding='utf-8') as f:
        typ_text = f.read()
        
    tex_secs = re.findall(r'\\(?:section|subsection|subsubsection)\{([^}]+)\}', tex_text)
    typ_secs = re.findall(r'^={2,4}\s+(.+)$', typ_text, re.MULTILINE)
    
    tex_listings = len(re.findall(r'\\begin\{lstlisting\}', tex_text))
    typ_listings = len(re.findall(r'```', typ_text)) // 2
    
    tex_figs = len(re.findall(r'\\begin\{figure\}', tex_text))
    tex_tbls = len(re.findall(r'\\begin\{table\}', tex_text))
    typ_figs = len(re.findall(r'#figure\(', typ_text))
    
    tex_words = len(re.findall(r'\b[A-Za-z]+\b', tex_text))
    typ_words = len(re.findall(r'\b[A-Za-z]+\b', typ_text))
    
    print(f'=== Chapter {i} ({tex_files[0]}) ===')
    print(f'  LaTeX: sections={len(tex_secs)}, listings={tex_listings}, figures={tex_figs}, tables={tex_tbls}, words={tex_words}')
    print(f'  Typst: sections={len(typ_secs)}, listings={typ_listings}, figures/tables={typ_figs}, words={typ_words}')
    
    tex_sec_clean = [s.replace(r'\&', '&').strip() for s in tex_secs]
    typ_sec_clean = [s.strip() for s in typ_secs]
    diff = set(tex_sec_clean) - set(typ_sec_clean)
    if diff:
        print(f'  MISSING sections in Typst: {diff}')
    else:
        print(f'  All sections match 100%!')
