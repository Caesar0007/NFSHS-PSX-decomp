"""Read-only validation of original-main compiler-input provenance receipts.

This proves only the source-group ownership of a measured compilation input.
It does NOT normalize any filename in native/retail SLD comparison, pair a
function by name/address/order, or certify code, type, scope or line equality.
Missing, malformed or stale receipts never provide a fallback owner.

The producer retains the fresh untouched CPP input and actual rewritten CC1
input. Replaying the small allowlisted main-input policy must reproduce both
the complete input bytes and the complete witness. All paths are root-relative;
all source, input, assembly, SN-object, policy, build-manifest and native-dump
hashes are checked against files read during validation. No subprocess/writes.
"""
import ast
import hashlib
import json
from pathlib import Path, PurePosixPath
import re
import types


TOP_FIELDS = frozenset(('schema', 'native_dump_sha256', 'units'))
UNIT_FIELDS = frozenset((
    'source', 'source_sha256', 'canonical_main', 'included_sources',
    'before_input', 'compiler_input', 'assembly', 'sn_object',
    'build_manifest_sha256', 'policy_sha256', 'origin'))
ARTIFACT_FIELDS = frozenset(('path', 'sha256'))
INCLUDE_FIELDS = frozenset(('source', 'source_sha256', 'canonical_source'))
SHA = re.compile(r'[0-9a-f]{64}\Z')
CPP_MARKER = re.compile(r'^\s*#\s*(?:line\s+)?\d+\s+("(?:\\.|[^"\\])*")\s*((?:\d+\s*)*)$')
ASM_FILE = re.compile(r'^\s*\.file\s+(?:\d+\s+)?"([^"\r\n]+)"\s*$', re.M)
TRIVIA = re.compile(r'("(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\')|/\*.*?\*/|//[^\r\n]*', re.S)
DIRECT_INCLUDE = re.compile(r'^\s*#\s*include\s+"([^"\r\n]+)"\s*$', re.M)
# Original included-file identities require their own explicit evidence policy.
# A future declared source must NOT acquire a retail identity by uppercasing
# its checkout directory spelling.
_INCLUSION_IDENTITIES = types.MappingProxyType({
    'recon/game/common/speech.cpp': types.MappingProxyType({
        'recon/game/common/spchevnt.c': 'C:/nfs4/GAME/COMMON/SPCHEVNT.C',
    }),
    'recon/frontend/common/femenudefs.cpp': types.MappingProxyType({}),
})


class EvidenceError(ValueError):
    """An invalid witness cannot supply source ownership."""


def _sha(data):
    return hashlib.sha256(data).hexdigest()


def _policy():
    """Load only our adjacent trusted policy, with no import-path/pyc writes.

    A fixture/source root does not choose executable Python for the validator.
    Its policy file must independently hash-identically to this implementation.
    Recompile the tiny pure policy in memory so cached imports cannot attest a
    newly edited policy using previously imported code.
    """
    path = Path(__file__).resolve().parents[1] / 'compiler_input_origin.py'
    module = types.ModuleType('_nfs4_origin_evidence_policy')
    module.__file__ = str(path)
    exec(compile(path.read_bytes(), str(path), 'exec'), module.__dict__)
    return module


def _fields(value, expected, label):
    if type(value) is not dict or set(value) != expected:
        raise EvidenceError(label + ': unexpected or missing schema fields')


def _exact(first, second):
    """JSON witness equality must not equate True with integer1 or1.0."""
    if type(first) is not type(second):
        return False
    if type(first) is dict:
        return first.keys() == second.keys() and all(_exact(first[key], second[key]) for key in first)
    if type(first) is list:
        return len(first) == len(second) and all(_exact(a, b) for a, b in zip(first, second))
    return first == second


def _unique_object(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise EvidenceError('sidecar: duplicate JSON field ' + key)
        result[key] = value
    return result


def _sidecar(native_dump):
    data = json.loads(native_dump.with_suffix('.origin.json').read_text(encoding='utf-8'),
                      object_pairs_hook=_unique_object)
    _fields(data, TOP_FIELDS, 'sidecar')
    if type(data['schema']) is not int or data['schema'] != 1 or type(data['units']) is not list:
        raise EvidenceError('sidecar: unsupported schema or units container')
    digest = _sha(native_dump.read_bytes())
    if _digest(data['native_dump_sha256'], 'native dump') != digest:
        raise EvidenceError('native dump: stale or mismatched SHA256')
    return data, digest


def _digest(value, label):
    if type(value) is not str or SHA.fullmatch(value) is None:
        raise EvidenceError(label + ': invalid SHA256')
    return value


def _path(root, value, label):
    if (type(value) is not str or not value or '\\' in value or '\x00' in value
            or ':' in value or value.startswith('/') or '//' in value
            or any(part in ('', '.', '..') for part in value.split('/'))):
        raise EvidenceError(label + ': expected an unambiguous root-relative POSIX path')
    path = (root / PurePosixPath(value)).resolve()
    if not path.is_relative_to(root) or not path.is_file():
        raise EvidenceError(label + ': file missing or path escapes root')
    return path


def _read_bound(root, path_string, digest, label, bindings):
    path = _path(root, path_string, label)
    data = path.read_bytes()
    if _sha(data) != _digest(digest, label):
        raise EvidenceError(label + ': stale or mismatched SHA256')
    bindings[path] = digest
    return path, data


def _artifact(root, record, suffix, label, bindings):
    _fields(record, ARTIFACT_FIELDS, label)
    path, data = _read_bound(root, record['path'], record['sha256'], label, bindings)
    if path.suffix.lower() != suffix:
        raise EvidenceError(label + ': wrong artifact suffix')
    if not data:
        raise EvidenceError(label + ': empty artifact')
    return path, data


def _included_sources(build_bytes):
    """Read a literal role declaration, without importing/executing build.py."""
    try:
        tree = ast.parse(build_bytes.decode('utf-8'))
        declarations = [node.value for node in tree.body if isinstance(node, ast.Assign)
                        and any(isinstance(target, ast.Name) and target.id == 'INCLUDED_SOURCES'
                                for target in node.targets)]
        if len(declarations) != 1:
            raise EvidenceError('INCLUDED_SOURCES: missing or ambiguous declaration')
        declared = ast.literal_eval(declarations[0])
    except (UnicodeError, SyntaxError, ValueError, TypeError) as error:
        raise EvidenceError('INCLUDED_SOURCES: not a literal role declaration') from error
    if type(declared) not in (set, frozenset) or not all(type(path) is str for path in declared):
        raise EvidenceError('INCLUDED_SOURCES: expected a literal set of paths')
    return declared


def _literal_edges(source, source_bytes, root):
    text = source_bytes.decode('utf-8').replace('\\\r\n', '').replace('\\\n', '')
    text = TRIVIA.sub(lambda match: match.group() if match.group(1) else
                      re.sub(r'[^\r\n]', ' ', match.group()), text)
    targets = set()
    for match in DIRECT_INCLUDE.finditer(text):
        name = match[1]
        if '\\' in name or ':' in name or name.startswith('/'):
            continue
        target = (source.parent / name).resolve()
        if target.is_relative_to(root) and target.is_file():
            targets.add(target)
    return targets


def _physical_identity(value):
    # Representation-only matching of CPP include-entry filenames to actual
    # source paths. This is NEVER used on native/retail SLD event filenames.
    return re.sub(r'[\\/]+', '/', value).casefold()


def _include_entries(input_bytes):
    entries = set()
    for line in input_bytes.decode('utf-8').splitlines():
        marker = CPP_MARKER.fullmatch(line)
        if marker is None or 1 not in [int(flag) for flag in marker[2].split()]:
            continue
        try:
            filename = ast.literal_eval(marker[1])
        except (SyntaxError, ValueError):
            raise EvidenceError('before_input: malformed CPP include filename')
        if type(filename) is str:
            entries.add(_physical_identity(filename))
    return entries


def _validate_unit(record, native_dump, root, native_digest):
    _fields(record, UNIT_FIELDS, 'unit')
    bindings = {}
    policy = _policy()
    identities = policy.identities()
    source_key = record['source']
    if type(source_key) is not str or source_key not in identities:
        raise EvidenceError('unit: unknown original-main source policy')
    canonical = identities[source_key]
    inclusion_policy = _INCLUSION_IDENTITIES.get(source_key)
    if inclusion_policy is None:
        raise EvidenceError('unit: no explicit included-source identity policy')
    if record['canonical_main'] != canonical:
        raise EvidenceError('unit: canonical main differs from declared policy')
    policy_path, policy_bytes = _read_bound(root, 'tools/compiler_input_origin.py',
                                           record['policy_sha256'], 'policy', bindings)
    if _sha(Path(policy.__file__).read_bytes()) != _sha(policy_bytes):
        raise EvidenceError('policy: imported implementation differs from bound policy')
    if policy.policy_sha256() != record['policy_sha256']:
        raise EvidenceError('policy: implementation hash differs')
    _, build_bytes = _read_bound(root, 'tools/build.py', record['build_manifest_sha256'],
                                 'build manifest', bindings)
    declared = _included_sources(build_bytes)
    source, source_bytes = _read_bound(root, source_key, record['source_sha256'],
                                       'source', bindings)
    if not source_key.startswith('recon/') or source_key in declared:
        raise EvidenceError('unit: main source is not an independent reconstruction TU')
    edges = _literal_edges(source, source_bytes, root)
    expected = {}
    for key in declared:
        included_path = _path(root, key, 'INCLUDED_SOURCES member')
        if not key.startswith('recon/') or included_path.suffix.lower() not in ('.c', '.cpp'):
            raise EvidenceError('INCLUDED_SOURCES: not a reconstructed source member')
        if included_path in edges:
            expected[key] = included_path
    if set(expected) != set(inclusion_policy):
        raise EvidenceError('INCLUDED_SOURCES: literal source group differs from explicit inclusion policy')
    inclusions = record['included_sources']
    if type(inclusions) is not list:
        raise EvidenceError('included_sources: expected a list')
    seen = set()
    canonical_group = {canonical}
    include_hashes = {}
    for inclusion in inclusions:
        _fields(inclusion, INCLUDE_FIELDS, 'included source')
        key = inclusion['source']
        if type(key) is not str or key in seen or key not in expected:
            raise EvidenceError('included source: not a unique declared literal include edge')
        seen.add(key)
        included_path, _ = _read_bound(root, key, inclusion['source_sha256'],
                                       'included source', bindings)
        canonical_include = inclusion_policy[key]
        if inclusion['canonical_source'] != canonical_include:
            raise EvidenceError('included source: canonical identity differs from declared path')
        canonical_group.add(canonical_include)
        include_hashes[key] = inclusion['source_sha256']
    if seen != set(expected):
        raise EvidenceError('included_sources: missing a declared literal source inclusion')
    before_path, before = _artifact(root, record['before_input'], '.i', 'before_input', bindings)
    input_path, actual_input = _artifact(root, record['compiler_input'], '.i', 'compiler_input', bindings)
    assembly_path, assembly = _artifact(root, record['assembly'], '.s', 'assembly', bindings)
    object_path, _ = _artifact(root, record['sn_object'], '.obj', 'sn_object', bindings)
    if len({before_path, input_path, assembly_path, object_path}) != 4:
        raise EvidenceError('unit: artifact paths are not independent')
    entries = _include_entries(before)
    if any(_physical_identity(str(path)) not in entries for path in expected.values()):
        raise EvidenceError('before_input: declared include has no CPP include-entry marker')
    rewritten, witness = policy.rewrite_main_input(
        root, source, before, expected_source_sha256=record['source_sha256'])
    if witness is None or type(record['origin']) is not dict or not _exact(witness, record['origin']):
        raise EvidenceError('origin: witness does not exactly replay from retained CPP input')
    if rewritten != actual_input:
        raise EvidenceError('compiler_input: does not equal exact policy replay')
    assembly_files = ASM_FILE.findall(assembly.decode('utf-8'))
    if not assembly_files or assembly_files[0] != canonical:
        raise EvidenceError('assembly: first file identity is not the canonical main')
    if not canonical_group.issubset(set(assembly_files)):
        raise EvidenceError('assembly: missing a canonical source-group filename')
    if _sha(native_dump.read_bytes()) != native_digest:
        raise EvidenceError('native dump changed during evidence validation')
    for path, digest in bindings.items():
        if _sha(path.read_bytes()) != digest:
            raise EvidenceError('bound input changed during evidence validation: ' + str(path))
    return dict(kind='validated_original_main_source_group', unit=source.stem.lower(),
                primary_source=source_key, included_sources=sorted(seen),
                source_group=sorted(canonical_group), source_sha256=record['source_sha256'],
                included_source_sha256=include_hashes, native_dump_sha256=native_digest,
                policy_sha256=record['policy_sha256'],
                build_manifest_sha256=record['build_manifest_sha256'],
                artifacts={name: dict(record[name]) for name in
                           ('before_input', 'compiler_input', 'assembly', 'sn_object')},
                provenance_only=True)


def validate_unit(record, *, native_dump, root):
    """Return (evidence, None), or (None, reason); never invent an owner."""
    try:
        native_dump, root = Path(native_dump), Path(root).resolve()
        sidecar, digest = _sidecar(native_dump)
        if sum(_exact(record, candidate) for candidate in sidecar['units']) != 1:
            raise EvidenceError('unit: not a unique exact sidecar member')
        evidence = _validate_unit(record, native_dump, root, digest)
        return evidence, None
    except (OSError, ValueError, TypeError, KeyError, AttributeError, ImportError,
            UnicodeError, SyntaxError, RecursionError) as error:
        return None, str(error)


def validated_units(native_dump, root, *, diagnostics=None):
    """Validate <native stem>.origin.json; return exact canonical-group keys.

    Invalid units contribute no mapping. Duplicate source claims invalidate all
    copies of that claim, not whichever entry happens to be encountered last.
    Optional diagnostics is a caller-owned list; it receives failure reasons.
    """
    reasons = diagnostics if diagnostics is not None else []
    native_dump, root = Path(native_dump), Path(root).resolve()
    try:
        data, digest = _sidecar(native_dump)
    except (OSError, ValueError, TypeError, UnicodeError, RecursionError) as error:
        reasons.append(str(error))
        return {}
    claims = {}
    for record in data['units']:
        key = record.get('source') if type(record) is dict else None
        if type(key) is str:
            claims[key] = claims.get(key, 0) + 1
    result = {}
    for record in data['units']:
        source = record.get('source') if type(record) is dict else None
        if type(source) is str and claims[source] != 1:
            reasons.append(source + ': duplicate unit claim')
            continue
        try:
            evidence = _validate_unit(record, native_dump, root, digest)
            group = frozenset(evidence['source_group'])
            if group in result:
                raise EvidenceError('sidecar: conflicting source-group claim')
            result[group] = evidence
        except (OSError, ValueError, TypeError, KeyError, AttributeError, ImportError,
                UnicodeError, SyntaxError, RecursionError) as error:
            reasons.append(str(source) + ': ' + str(error))
    try:
        if _sha(native_dump.read_bytes()) != digest:
            raise EvidenceError('native dump changed during evidence validation')
    except (OSError, ValueError) as error:
        reasons.append(str(error))
        return {}
    return result
