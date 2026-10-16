"""Check a saved runtime receipt still refers to current source and retail ROM.

This is an artifact-integrity check, NOT a new emulator run or universal proof.
"""
from pathlib import Path
import argparse
import hashlib
import json

ROOT=Path(__file__).resolve().parents[2]

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('receipt',type=Path)
    args=ap.parse_args()
    report=json.loads(args.receipt.read_text())
    assert report['passed'] is True
    assert report['ram_and_scratch_restored'] is True
    assert not(set(report['register_differences_after_restore'])-{'cause'})
    def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
    assert sha(ROOT/'rom/nfs4-f.exe')==report['rom_sha256'], 'retail ROM changed'
    for name,digest in report['native_source_sha256'].items():
        path=(ROOT/'ports'/name).resolve()
        assert path.is_relative_to((ROOT/'ports').resolve())
        assert sha(path)==digest, f'port source changed: {name}; runtime recheck required'
    assert sum(report['per_function'].values())==report['cases']
    print(json.dumps({'artifact_integrity':'PASS','runtime_rerun':False,
                      'cases':report['cases'],'bodies':len(report['per_function']),
                      'receipt':str(args.receipt)}))

if __name__=='__main__':main()
