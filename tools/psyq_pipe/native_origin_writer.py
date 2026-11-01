"""Bind genuine source-input provenance to ASPSX objects and dumpsym output.

2026-11-01: these sidecars are evidence, not rewritten instruction/debug data.
An absent or stale input witness is omitted; the owner decoder remains strict.
The executable/source pipeline never consumes this file to alter code or SYM.
"""
import hashlib
import json
from pathlib import Path


def _artifact(root, path):
    path = Path(path).resolve()
    return dict(path=path.relative_to(root.resolve()).as_posix(),
                sha256=hashlib.sha256(path.read_bytes()).hexdigest())


def capture_object(root, source, assembly, sn_object):
    """Called immediately after successful ASPSX, from its actual .s input."""
    root = Path(root).resolve()
    assembly, sn_object = Path(assembly), Path(sn_object)
    sidecar = assembly.with_suffix('.i.origin.json')
    if not sidecar.is_file():
        return None
    value = json.loads(sidecar.read_text(encoding='utf-8'))
    if value['source'] != Path(source).resolve().relative_to(root).as_posix():
        raise ValueError('ASPSX source/input origin mismatch')
    if value['assembly'] != _artifact(root, assembly):
        raise ValueError('ASPSX assembly/input origin mismatch')
    for key in ('before_input', 'compiler_input'):
        if value[key] != _artifact(root, root / value[key]['path']):
            raise ValueError('Stale ASPSX compiler input: ' + key)
    value['sn_object'] = _artifact(root, sn_object)
    destination = sn_object.with_suffix(sn_object.suffix + '.origin.json')
    destination.write_text(json.dumps(value, indent=2) + '\n', encoding='utf-8')
    return value


def write_dump_evidence(root, native_dump, object_directory):
    """Publish only witnesses that validate against this actual linked dump."""
    from compiler_origin_evidence import validate_unit
    root, native_dump = Path(root).resolve(), Path(native_dump)
    candidates, units, diagnostics = [], [], []
    for path in sorted(Path(object_directory).glob('*.obj.origin.json')):
        try:
            value = json.loads(path.read_text(encoding='utf-8'))
            candidates.append((path, value))
        except (OSError, ValueError, KeyError, TypeError) as error:
            diagnostics.append(dict(path=str(path), reason=str(error)))
    destination = native_dump.with_suffix('.origin.json')
    def publish(values):
        result = dict(schema=1, native_dump_sha256=hashlib.sha256(native_dump.read_bytes()).hexdigest(),
                      units=values)
        temporary = destination.with_suffix(destination.suffix + '.tmp')
        temporary.write_text(json.dumps(result, indent=2) + '\n', encoding='utf-8')
        temporary.replace(destination)
    # The validator independently requires membership in this dump-bound
    # sidecar. Candidate rows are not trusted: any malformed/stale row remains
    # unusable to readers until it passes all hashes, policy and include checks.
    publish([value for _, value in candidates])
    for path, value in candidates:
        try:
            evidence, reason = validate_unit(value, native_dump=native_dump, root=root)
            if evidence is None:
                diagnostics.append(dict(path=str(path), reason=reason))
            else:
                units.append(value)
        except (OSError, ValueError, KeyError, TypeError) as error:
            diagnostics.append(dict(path=str(path), reason=str(error)))
    publish(units)
    native_dump.with_suffix('.origin-diagnostics.json').write_text(json.dumps(diagnostics, indent=2) + '\n', encoding='utf-8')
    return len(units)
