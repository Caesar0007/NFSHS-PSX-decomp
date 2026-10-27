"""Read-only native-versus-retail label/function-storage comparison.

SYM label kinds1/2 are global and6 is local. This is independent of normalized
instruction bytes,word SLD and function-local declaration coverage.

2026-10-27: replace the obsolete scratchpad input by the current native build;
add explicit input/report arguments,hash-bound results and function EXT/STAT
checks. Preserve every matching raw record and flag ambiguous names rather
than choosing the first local copy. No source,object,SYM or reference rewrite.
Backup:build/nc12/record_header_20261026/sym_linkage-before.py.
Legacy CLI remains: sym_linkage.py [LIMIT] [--only].
"""
import argparse
from collections import Counter,defaultdict
import hashlib
import json
from pathlib import Path
import re

ROOT=Path(__file__).resolve().parents[2]
DEFAULT_NATIVE=ROOT/'build/psyq_g/nfs4_sym.txt'
LABEL=re.compile(r'^([0-9a-fA-F]+): \$([0-9a-fA-F]{8}) ([126]) (\S+)$')
FUNCTION=re.compile(r'^([0-9a-fA-F]+): \$([0-9a-fA-F]{8}) (94|96) Def2? class (EXT|STAT) type FCN (.*?) name (\S+)$')


def canonical_name(name):
    # Existing cfront destructor spelling equivalence,not a semantic rename.
    return '___'+name[3:] if name.startswith('_._') else name


def read_records(path):
    labels=defaultdict(list);functions=defaultdict(list)
    # Hash the SAME bytes that are parsed;concurrent native rebuilds must not
    # bind an earlier parse to a later file snapshot.
    path=Path(path).resolve();data=path.read_bytes()
    for line_number,line in enumerate(data.decode('utf-8',errors='replace').splitlines(),1):
            line=line.rstrip('\r\n');m=LABEL.fullmatch(line)
            if m:
                offset,address,kind,original=m.groups()
                labels[canonical_name(original)].append(dict(
                    line=line_number,offset=offset,address=int(address,16),kind=int(kind),original_name=original))
            m=FUNCTION.fullmatch(line)
            if m:
                offset,address,kind,storage,payload,original=m.groups()
                functions[canonical_name(original)].append(dict(
                    line=line_number,offset=offset,address=int(address,16),record_kind=kind,
                    storage=storage,payload=payload,original_name=original))
    if not labels and not functions:
        raise ValueError('No supplied label/function-storage records in '+str(path))
    return {'labels':dict(labels),'function_storage':dict(functions),
            'input_snapshot':dict(path=str(path),bytes=len(data),sha256=hashlib.sha256(data).hexdigest())}


def compare_groups(native,retail,field):
    mismatches=[];global_kinds=[];ambiguous=[];common=set(native)&set(retail)
    for name in sorted(common):
        n={(x[field],x['address']) for x in native[name]}
        r={(x[field],x['address']) for x in retail[name]}
        if len(n)!=1 or len(r)!=1:
            ambiguous.append(dict(name=name,native=native[name],retail=retail[name]))
            continue
        nv,na=next(iter(n));rv,ra=next(iter(r))
        row=dict(name=name,native_value=nv,retail_value=rv,native_address=na,retail_address=ra,
                 native=native[name],retail=retail[name])
        if field=='kind':
            if (nv==6)!=(rv==6):mismatches.append(row)
            elif nv!=rv:global_kinds.append(row)
        elif nv!=rv:mismatches.append(row)
    return dict(common_names=len(common),unambiguous_names=len(common)-len(ambiguous),
                mismatches=mismatches,global_kind_differences=global_kinds,
                ambiguous_names_NOT_compared=ambiguous,
                retail_only={n:retail[n] for n in sorted(set(retail)-set(native))},
                native_only={n:native[n] for n in sorted(set(native)-set(retail))})


def report(native_path,retail_path):
    native=read_records(native_path);retail=read_records(retail_path)
    return dict(schema=1,
        scope='All supplied label1/2/6 records and EXT/STAT function declarations;not a complete source/SYM certificate',
        inputs={'native':native['input_snapshot'],'retail':retail['input_snapshot']},
        label_linkage=compare_groups(native['labels'],retail['labels'],'kind'),
        function_storage=compare_groups(native['function_storage'],retail['function_storage'],'storage'),
        raw_records={'native':native,'retail':retail},
        limitations=[
            'Address differences are retained,not treated as linkage differences: native layout may differ.',
            'Multiple different addresses/kinds/storage classes for one name require owner-aware investigation.',
            'Repeated identical records are retained,not additional independently named symbols.',
            'Global kind1-versus2 differences are reported separately,not silently equated as exact records.',
            'Missing declarations and stripped SDK/EAC information are not complete library coverage.',
            'Matching linkage/storage does not prove instructions,types,owners,SLD,or original source text.'])


def main(argv=None):
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('limit',type=int,nargs='?',default=60)
    parser.add_argument('--native',type=Path,default=DEFAULT_NATIVE)
    parser.add_argument('--retail',type=Path)
    parser.add_argument('--report',type=Path)
    parser.add_argument('--only',action='store_true',help='also print supplied-label-only names')
    args=parser.parse_args(argv)
    if args.limit<0:parser.error('LIMIT must be nonnegative')
    if args.retail is None:
        import retail_sym
        args.retail=Path(retail_sym.txt())
    if args.report:
        output=args.report.resolve()
        for source in (args.native,args.retail):
            if output==source.resolve() or (output.exists() and output.samefile(source)):
                parser.error('Report output must not overwrite an input SYM dump')
    result=report(args.native,args.retail);labels=result['label_linkage'];functions=result['function_storage']
    raw=result['raw_records'];n=raw['native']['labels'];r=raw['retail']['labels']
    print('labels: ours %d retail %d common %d' % (len(n),len(r),labels['common_names']))
    print('kinds ours',Counter(x['kind'] for rows in n.values() for x in rows),
          'retail',Counter(x['kind'] for rows in r.values() for x in rows))
    print('linkage mismatches',len(labels['mismatches']))
    for row in sorted(labels['mismatches'],key=lambda x:(x['retail_address'],x['name']))[:args.limit]:
        print('   %08x retail %d ours %d  %s' % (row['retail_address'],row['retail_value'],row['native_value'],row['name'][:90]))
    print('function EXT/STAT mismatches',len(functions['mismatches']))
    print('ambiguous label/function names',len(labels['ambiguous_names_NOT_compared']),len(functions['ambiguous_names_NOT_compared']))
    print('global kind1/2 differences',len(labels['global_kind_differences']))
    print('only retail',len(labels['retail_only']),'only ours',len(labels['native_only']))
    if args.only:
        for prefix,key in [('R','retail_only'),('O','native_only')]:
            for name,rows in list(labels[key].items())[:80]:
                print('   %s %08x %d %s' % (prefix,rows[0]['address'],rows[0]['kind'],name[:90]))
    if args.report:
        args.report.parent.mkdir(parents=True,exist_ok=True)
        args.report.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
        print('Diagnostic only:',args.report)
    return result


if __name__=='__main__':
    main()
