#!/usr/bin/env python3
"""Build the same-address Stage-1 syslib candidate and inject it into a test disc image."""
import argparse, hashlib, json, struct, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
PAIR = Path(r'C:\Temp\nfs4-syslib-pair')
RETAIL_EXE = ROOT / 'rom' / 'nfs4-f.exe'
RETAIL_IMAGE = Path(r'C:\Temp\nfs4iso\NFS4.IMG')
PATCHES = {
    # name: (VA, byte extent, return value).  Same-address proof build; unused bytes become NOPs.
    'FntFlush': (0x800F6D18, 0x31C, 0),
    'PCread':   (0x80106BE4, 0x0C0, -1),
    'PCopen':   (0x80106CA4, 0x020, -1),
    'PCinit':   (0x80106CC4, 0x00C, 0),
    # PCcreat ends at 0x80106CF0; EAC psxdevelopmentsystem occupies 0x80106CF0..0x80106D1C.
    'PCcreat':  (0x80106CD0, 0x020, -1),
    'PClseek':  (0x80106D1C, 0x024, -1),
    'PCclose':  (0x80106D40, 0x010, 0),
    'PCwrite':  (0x80106D50, 0x0C0, -1),
}
JR_RA = 0x03E00008
NOP = 0

def sha(data): return hashlib.sha256(data).hexdigest()

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--variant', choices=('font','pc','combined'), default='combined')
    args = parser.parse_args()
    out = PAIR / ('candidate-image' if args.variant == 'combined' else f'candidate-image-{args.variant}')
    patches = {name:spec for name,spec in PATCHES.items()
               if args.variant == 'combined' or (args.variant == 'font') == (name == 'FntFlush')}
    out.mkdir(parents=True, exist_ok=True)
    source = RETAIL_EXE.read_bytes(); data = bytearray(source)
    load, size = struct.unpack_from('<II', data, 0x18)
    rows = []
    for name, (va, extent, value) in patches.items():
        offset = 0x800 + va - load
        if offset < 0x800 or offset + extent > 0x800 + size or extent < 8 or extent % 4:
            raise ValueError(f'bad patch range {name}')
        before = bytes(data[offset:offset+extent])
        fill = 0x2402FFFF if value == -1 else 0x00001021  # addiu v0,zero,-1 / addu v0,zero,zero
        words = [JR_RA, fill] + [NOP] * (extent // 4 - 2)
        data[offset:offset+extent] = struct.pack('<%dI' % len(words), *words)
        rows.append(dict(name=name, va=f'{va:08X}', size=extent,
                         retail_sha256=sha(before), candidate_sha256=sha(data[offset:offset+extent]),
                         return_value=value))
    exe = out / 'NFS4.EXE'; exe.write_bytes(data)
    image = out / f'NFS4-SYSLIB-STAGE1-{args.variant.upper()}.IMG'
    injector = ROOT / 'docs' / 'nfs-psx-formats' / 'tools' / 'psx_iso_inject.py'
    subprocess.run([sys.executable, str(injector), str(RETAIL_IMAGE), str(image), str(out), 'NFS4.EXE'],
                   cwd=ROOT, check=True)
    savings = {'font':22276,'pc':516,'combined':22792}[args.variant]
    report = dict(schema='nfs4-syslib-stage1-image-v1', variant=args.variant, same_address=True,
                  source_exe=str(RETAIL_EXE), source_exe_sha256=sha(source),
                  candidate_exe=str(exe), candidate_exe_sha256=sha(data),
                  image=str(image), image_sha256=sha(image.read_bytes()),
                  cue=str(image.with_suffix('.cue')), load=f'{load:08X}', image_size=size,
                  patches=rows, code_ranges=[[row['va'],row['size']] for row in rows],
                  expected_runtime_reclaim=0,
                  eventual_compacted_saving=savings)
    (out/'image-report.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(report,indent=2))

if __name__ == '__main__': main()
