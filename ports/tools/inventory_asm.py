"""Inventory non-SDK assembly without counting comments/empty matching fences.

Whole assembly modules, inline instruction templates, data/linkage directives,
and compiler-only fences are separate. This is a site census, not a claim that
every enclosing game function or every execution path has been ported.
"""
from pathlib import Path
import hashlib
import json
import re

ROOT = Path(__file__).resolve().parents[2]
TOKEN = re.compile(r'"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'|/\*.*?\*/|//[^\n]*',re.S)
ASM = re.compile(r'\b(?:__asm__|asm|__asm)\b\s*(?:(?:__volatile__|volatile)\s*)?\(')
INSTRUCTION = re.compile(r'(?m)^\s*(?:add(?:iu|i|u)?|subu?|sltu?|sltiu?|s[rl][al]v?|'
                         r'ori?|andi?|xori?|nor|l[bhw](?:u|l|r)?|s[bhw](?:l|r)?|'
                         r'b(?:eqz?|nez?|gez|gtz|lez|ltz)|j(?:alr?|r)?|'
                         r'm[ft](?:lo|hi|c[02])|c[ft]c[02]|cop2|multu?|divu?|'
                         r'negu?|move|nop|rfe|syscall)\b')
COVERED = {'blkfill','blkmov','fixdmult','fixddiv','fixdinv','fixdsqrt','random',
           'crc','getm','math64a','shpdepth','savegp','sinfunc','shpsubs'}

def clean(text):
    return TOKEN.sub(lambda m: m[0] if m[0][0] in '\"\'' else
                     ''.join('\n' if c=='\n' else ' ' for c in m[0]),text)

def body(text, start):
    depth=1; i=start
    while i<len(text) and depth:
        if text[i] in '\"\'':
            m=TOKEN.match(text,i)
            if m: i=m.end();continue
        if text[i]=='(':depth+=1
        elif text[i]==')':depth-=1
        i+=1
    assert depth==0, 'unbalanced asm expression'
    return text[start:i-1]

def decode(text):
    # Operand constraints/clobbers are strings too; they are not instructions.
    # Macro line continuations and #stringification can interrupt a literal
    # sequence; collect all literals in the FIRST operand, stopping at its
    # unquoted top-level colon. Do not misclassify hardware macro definitions
    # as empty compiler fences just because '(' is followed by a backslash.
    text=text.replace('\\\r\n','').replace('\\\n','')
    strings=[];i=0;depth=0
    while i<len(text):
        if text[i]=='"':
            literal=re.match(r'"(?:\\.|[^"\\])*"',text[i:],re.S)
            assert literal, 'unfinished template literal'
            strings.append(literal[0]);i+=len(literal[0]);continue
        if text[i]==':' and depth==0:break
        if text[i]=='(':depth+=1
        elif text[i]==')':depth-=1
        i+=1
    # All assembly templates are ASCII. Preserve literal newlines accepted by old GCC.
    import codecs
    return ''.join(codecs.decode(s[1:-1],'unicode_escape') for s in strings)

def main():
    sites=[]; counts={}
    for directory in ('eaclib','game','frontend'):
        for path in sorted((ROOT/'recon'/directory).rglob('*')):
            if path.suffix not in ('.c','.cpp','.h'):continue
            text=path.read_text(errors='replace')
            stripped=clean(text)
            for match in ASM.finditer(stripped):
                expr=body(stripped,match.end())
                template=decode(expr)
                exports=re.findall(r'\.glob(?:l|al)\s+([A-Za-z_][\w.]*)',template)
                if not template.strip():kind='empty_codegen_fence'
                elif INSTRUCTION.search(template):
                    kind='whole_assembly_code' if exports else 'inline_runtime_assembly'
                elif '.word' in template and not exports and not re.search(r'\.(?:section|data|bss)\b',template):
                    kind='inline_opcode_requires_review'
                elif re.search(r'\.(?:word|byte|half|space|section|globl|global|text)\b',template):
                    kind='data_or_linkage_directives'
                else:kind='linkage_alias_or_unclassified'
                counts[kind]=counts.get(kind,0)+1
                if kind=='empty_codegen_fence':continue
                status='pending'
                if kind=='whole_assembly_code' and path.stem in COVERED:
                    status='C implementation present; see runtime evidence for tested domain'
                if kind=='data_or_linkage_directives':status='not a runtime function; no instruction port required'
                if kind=='linkage_alias_or_unclassified' and re.fullmatch(r'[\w.$]+',template):
                    status='symbol-name annotation, not executable assembly; host linkage integration only'
                sites.append({'source':path.relative_to(ROOT).as_posix(),
                              'line':text.count('\n',0,match.start())+1,
                              'kind':kind,'exports':exports,'status':status,
                              'source_sha256':hashlib.sha256(path.read_bytes()).hexdigest()})
    original_modules=[]
    for name in re.findall(r'(?im)^([^\n]*\.ASM)\s*$',(ROOT/'configs/sym_source_langs.txt').read_text()):
        stem=Path(name.strip().replace('\\','/')).stem.lower()
        status='portable C body present; tested domains in ports runtime receipts'
        if stem=='address':status='overlay boundary data; no runtime function to reconstruct'
        elif stem=='nullfunc':status='shared null body ported; individual alias prototypes need host integration'
        original_modules.append({'retail_source':name.strip(),'status':status})
    report={'scope':'recon/eaclib, recon/game, recon/frontend; SDK recon/syslib excluded',
            'counts':counts,'original_assembly_modules':original_modules,'sites':sites,
            'limitations':'Site inventory includes inline macros and declarations, not every consumer of shared GTE macros. Pending does not imply a whole function has no existing C; empty fences have no runtime operation.'}
    target=ROOT/'ports/assembly_inventory.json'
    target.write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps({'inventory':str(target),'counts':counts,'listed_sites':len(sites)}))

if __name__=='__main__':main()
