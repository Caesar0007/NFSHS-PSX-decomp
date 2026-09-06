"""Commit hygiene for new diagnostic text only; never production source.

Remove spaces on otherwise empty lines and excess empty EOF lines. Check C/C++
tokens and their source lines, and JSON values, before accepting a rewrite.
The receipt retains input/output hashes; compiler/oracle objects are untouched.
"""
from pathlib import Path
import hashlib
import json
import re
import subprocess

ROOT=Path(__file__).resolve().parents[2]
run=subprocess.run(['git','diff','--cached','--check'],cwd=ROOT,capture_output=True,text=True)
paths=sorted(set(re.findall(r'(?m)^([^\n]+):\d+: (?:trailing whitespace|new blank line at EOF)\.',run.stdout)))
token=re.compile(r'''"(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*'|/\*.*?\*/|//[^\n]*|[A-Za-z_]\w*|\d+(?:\.\d*)?|[^\s]''',re.S)
def code_tokens(data):
    text=data.decode('utf-8').replace('\r\n','\n')
    return [(m[0],text.count('\n',0,m.start())+1) for m in token.finditer(text)
            if not m[0].startswith(('/*','//'))]
rows=[]
for name in paths:
    assert name.startswith('scratchpad/') and '..' not in Path(name).parts,name
    path=ROOT/name
    before=path.read_bytes()
    after=re.sub(rb'(?m)^[ \t]+(?=\r?$)',b'',before)
    ending=b'\r\n' if before.endswith(b'\r\n') else b'\n'
    after=after.rstrip(b'\r\n')+ending
    if path.suffix in ('.c','.cpp','.h'):
        assert code_tokens(before)==code_tokens(after),name
    if path.suffix=='.json':
        assert json.loads(before)==json.loads(after),name
    assert before!=after,name
    path.write_bytes(after)
    rows.append(dict(path=name,before_sha256=hashlib.sha256(before).hexdigest(),
                     after_sha256=hashlib.sha256(after).hexdigest(),
                     only_empty_line_whitespace_or_eof=True,
                     code_token_lines_preserved=path.suffix in ('.c','.cpp','.h')))
target=Path(__file__).with_name('snapshot_formatting_receipt.json')
target.write_text(json.dumps(rows,indent=2)+'\n')
print('Formatted',len(rows),'diagnostic text files; no production or object changes.')
