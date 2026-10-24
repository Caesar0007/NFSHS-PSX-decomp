"""Read-only per-word MND source-file comparison, independent of SLD headers.

2026-10-23: checkpoints depended on an ignored file_sld.py that disappeared.
Keep the filename-stream decoder/test here rather than restore deleted build
folders or silently accept a matching function header as word-file coverage.
Only slash/escape repetition, optional quotes and Windows case are normalized;
different directories with the same basename MUST remain different. No source,
compiler output, reference, SYM or instruction data is rewritten.
"""
import bisect
import re
from pathlib import Path

REC = re.compile(r'^[0-9a-fA-F]+: \$([0-9a-fA-F]{8}) ([0-9a-fA-F]{1,2}) (.*)$')
FILE = re.compile(r'^Set SLD to line \d+ of file (.+?)\s*$')


def normalize(path):
    if path is None:
        return None
    return re.sub(r'[\\/]+', '/', path.strip().strip('"')).casefold()


def events(path):
    """Return sorted address keys and the last filename event at each VA."""
    values = {}
    with Path(path).open(errors='replace') as stream:
        for line in stream:
            record = REC.match(line.rstrip('\r\n'))
            if not record or record[2].lower() != '88':
                continue
            match = FILE.match(record[3])
            if match:
                values[int(record[1], 16)] = match[1]
    return sorted(values), values


def file_at(stream, address):
    keys, values = stream
    index = bisect.bisect_right(keys, address) - 1
    return values[keys[index]] if index >= 0 else None


def check(native_stream, retail_stream, native, retail, *, require_coverage=True):
    """Check each aligned word, not just the header; fail closed by default.

    Preservation audits may explicitly allow both missing values, but that is
    not a filename-coverage certificate. Native-versus-retail seals must keep
    the default and independently check function identity/lines/owners/bytes.
    """
    length = native['end'] - native['start']
    if length <= 0 or length % 4:
        raise AssertionError('Invalid native function bounds')
    if retail['end'] - retail['start'] != length:
        raise AssertionError('Function length differs')
    for offset in range(0, length, 4):
        n = normalize(file_at(native_stream, native['start'] + offset))
        r = normalize(file_at(retail_stream, retail['start'] + offset))
        if require_coverage and (n is None or r is None):
            raise AssertionError(('Missing word filename', offset, n, r))
        if n != r:
            raise AssertionError(('Word filename differs', offset, n, r))
