"""Compare all supplied function-local LABEL declarations without rewriting SYM.

2026-10-27: supplement the legacy local auditors, which exclude LABEL class.
Preserve duplicate raw records and decline ambiguous function-name copies;
compare function-relative label VAs, exact payloads and complete region owners.
Retail has five small LABEL values, unlike native linked code addresses. Keep
their raw values unresolved, never assume an object base or certify them equal.
This is a partial record audit, not a whole-source/byte/SLD certificate.
New tool: no existing comparator or reference is modified.
"""
import argparse
from collections import Counter,defaultdict
import hashlib,json,re
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
REC=re.compile(r'^([0-9a-fA-F]+): \$([0-9a-fA-F]{8}) ([0-9a-fA-F]{1,2}) (.*)$')
HDR=re.compile(r'^\s+(\w+) = (.*)$')
LABEL=re.compile(r'^Def2? class LABEL type (.*?) size (\d+)(?: dims .*?)?(?: tag \S*)? name (\S+)$')

def read_records(path):
 path=Path(path);data=path.read_bytes();functions=[];unowned=[];unparsed=[];current=None;stack=[];header=False
 for linenum,line in enumerate(data.decode('utf-8',errors='replace').splitlines(),1):
  match=REC.match(line)
  if not match:
   h=HDR.match(line)
   if current is not None and header and h:
    current['header'][h[1]]=h[2].strip()
    if h[1]=='name':
     name=h[2].strip();current['name']='_._'+name[3:] if name.startswith('___') else name;header=False
   continue
  offset,address,kind,payload=match.groups();address=int(address,16);kind=kind.lower()
  if kind=='8c':
   if current is not None:current['errors'].append('new function before preceding end')
   current=dict(start=address,end=None,header={},name=None,regions=[],labels=[],errors=[])
   functions.append(current);stack=[];header=True
  elif kind=='8e' and current is not None:
   current['end']=address
   if stack:current['errors'].append('unclosed source regions')
   current=None;stack=[];header=False
  elif kind=='90' and current is not None:
   parent=stack[-1] if stack else None
   peers=parent['children'] if parent else [r for r in current['regions'] if len(r['path'])==1]
   region=dict(path=(parent['path'] if parent else [])+[len(peers)],start=address-current['start'],end=None,children=[])
   if parent:parent['children'].append(region)
   current['regions'].append(region);stack.append(region)
  elif kind=='92' and current is not None:
   if stack:stack.pop()['end']=address-current['start']
   else:current['errors'].append('source region end without start')
  elif kind in ('94','96') and 'class LABEL ' in payload:
   label=LABEL.match(payload)
   if label is None:
    unparsed.append(dict(address=address,payload=payload,record_kind=kind,record_offset=offset,dump_line=linenum))
    if current is not None:current['errors'].append('unrecognized LABEL payload')
    continue
   row=dict(name=label[3],address=address,payload=payload,record_kind=kind,record_offset=offset,dump_line=linenum,
            owner_path=list(stack[-1]['path']) if stack else [])
   if current is None:unowned.append(row)
   else:current['labels'].append(row)
 if not functions:raise ValueError('No recognized function records in '+str(path))
 for fn in functions:
  if fn['name'] is None or fn['end'] is None:fn['errors'].append('incomplete function header/end')
  regions={tuple(r['path']):r for r in fn['regions']}
  for row in fn['labels']:
   # LABEL .val can survive retail as an unrelocated object quantity. Its exact
   # producer/base is not established by the surrounding function's linked VA.
   resolved=fn['end'] is not None and fn['start']<=row['address']<=fn['end']
   row['relative_address']=row['address']-fn['start'] if resolved else None
   row['address_form']='linked_function_code' if resolved else 'UNRESOLVED_RAW_LABEL_VALUE'
   region=regions.get(tuple(row['owner_path']))
   row['owner']=dict(path=row['owner_path'],start=region['start'] if region else 0,
                     end=region['end'] if region else (fn['end']-fn['start'] if fn['end'] is not None else None))
 return dict(input=dict(path=str(path.resolve()),sha256=hashlib.sha256(data).hexdigest()),
             functions=functions,unowned_LABEL_records=unowned,unparsed_LABEL_records=unparsed)

def identity(row):
 return (row['name'],row['record_kind'],row['payload'],row['relative_address'],
         tuple(row['owner']['path']),row['owner']['start'],row['owner']['end'])

def declaration_identity(row):
 value=identity(row)
 return value[:3]+value[4:]

def report(native,retail):
 N,R=map(read_records,(native,retail));groups=[]
 for stream in (N,R):
  group=defaultdict(list)
  for fn in stream['functions']:group[fn['name']].append(fn)
  groups.append(group)
 ng,rg=groups;rows=[];ambiguous=[];invalid=[]
 for name in sorted((set(ng)&set(rg))-{None}):
  if len(ng[name])!=1 or len(rg[name])!=1:
   ambiguous.append(dict(name=name,native=ng[name],retail=rg[name]));continue
  n,r=ng[name][0],rg[name][0]
  if n['errors'] or r['errors']:invalid.append(dict(name=name,native=n,retail=r));continue
  nc,rc=map(lambda f:Counter(identity(x) for x in f['labels']),(n,r))
  unresolved=any(x['relative_address'] is None for f in (n,r) for x in f['labels'])
  dc,dr=map(lambda f:Counter(declaration_identity(x) for x in f['labels']),(n,r))
  status=('DIFF_INCOMPLETE_ADDRESS' if dc!=dr else 'INCOMPLETE_ADDRESS') if unresolved else ('MATCH' if nc==rc else 'DIFF')
  rows.append(dict(name=name,native_header=n['header'],retail_header=r['header'],
                   native=n['labels'],retail=r['labels'],
                   native_only_records=[list(x) for x in (nc-rc).elements()],
                   retail_only_records=[list(x) for x in (rc-nc).elements()],
                   native_only_declarations=[list(x) for x in (dc-dr).elements()],
                   retail_only_declarations=[list(x) for x in (dr-dc).elements()],
                   raw_LABEL_address_producer_unresolved=unresolved,status=status))
 return dict(schema=1,scope='Function-local LABEL record audit only;not full source/SYM or byte/SLD exactness',
             inputs=dict(native=N['input'],retail=R['input']),functions=rows,
             counts=dict(compared=len(rows),different=sum(x['status'].startswith('DIFF') for x in rows),
                         unresolved_address_functions=sum(x['raw_LABEL_address_producer_unresolved'] for x in rows),
                         native_records=sum(len(f['labels']) for f in N['functions']),retail_records=sum(len(f['labels']) for f in R['functions'])),
             ambiguous_function_names_NOT_compared=ambiguous,invalid_function_records_NOT_compared=invalid,
             native_only_functions={k:v for k,v in ng.items() if k not in rg},retail_only_functions={k:v for k,v in rg.items() if k not in ng},
             unowned_LABEL_records=dict(native=N['unowned_LABEL_records'],retail=R['unowned_LABEL_records']),
             unparsed_LABEL_records_NOT_compared=dict(native=N['unparsed_LABEL_records'],retail=R['unparsed_LABEL_records']))

def main(argv=None):
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('--native',type=Path,default=ROOT/'build/psyq_g/nfs4_sym.txt')
 parser.add_argument('--retail',type=Path)
 parser.add_argument('--report',type=Path,required=True)
 args=parser.parse_args(argv)
 if args.retail is None:
  from retail_sym import txt
  args.retail=Path(txt())
 for source in (args.native,args.retail):
  if args.report.resolve()==source.resolve() or (args.report.exists() and args.report.samefile(source)):
   parser.error('Report output must not overwrite either input')
 result=report(args.native,args.retail);args.report.parent.mkdir(parents=True,exist_ok=True)
 args.report.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
 print('LABEL audit:',result['counts'],'ambiguous',len(result['ambiguous_function_names_NOT_compared']),
       'invalid',len(result['invalid_function_records_NOT_compared']))
 print('Diagnostic only:',args.report)
 return result

if __name__=='__main__':main()
