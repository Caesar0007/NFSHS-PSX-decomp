"""Bind two original main-source identities before CC1 reads fresh CPP input.

This is compiler INPUT construction, not a debug-output normalizer.  In GCC
2.8, the first CPP filename establishes main_input_filename; final.c drops
integrated source notes whose filename differs from it.  A later source #line
cannot repair that initial identity.  Only the two measured TUs below opt in;
applying this globally changes genuine inline-note behavior (AISTATE control).

No .s/.obj/.sym records, references, or non-marker source tokens are rewritten.
The caller must run CPP freshly and should capture the source hash before it.
An input filename alone cannot prove when an arbitrary .i was generated.
This module performs reads for hash binding, but never writes any files.
"""

from __future__ import annotations

import hashlib
import os
from pathlib import Path
import re
from types import MappingProxyType
from typing import Mapping


POLICY_VERSION = 1
POLICY_NAME = "nfs4-original-main-source"
_IDENTITIES = MappingProxyType({
    "recon/frontend/common/femenudefs.cpp":
        "C:/nfs4/FRONTEND/COMMON/FEMENUDEFS.CPP",
    "recon/game/common/speech.cpp": "C:/nfs4/GAME/COMMON/SPEECH.CPP",
    "recon/frontend/common/front.cpp": "C:/nfs4/FRONTEND/COMMON/FRONT.CPP",
})
_VIRTUAL_CPP_FILES = {"<built-in>", "<command-line>"}
_MARKER_START = re.compile(rb"^[ \t]*#[ \t]+[0-9]+\b")
_MARKER = re.compile(
    rb'^[ \t]*#[ \t]+(?P<number>[0-9]+)[ \t]+"'
    rb'(?P<filename>(?:[^"\\\r\n]|\\[^\r\n])*)"'
    rb'(?P<flags>(?:[ \t]+[0-9]+)*)[ \t]*$'
)
_SHA256 = re.compile(r"[0-9a-f]{64}\Z")


class InputOriginError(ValueError):
    """A declared TU's CPP input cannot be safely bound to its real source."""


def identities() -> Mapping[str, str]:
    """The exact opt-in source policy; callers cannot mutate it."""
    return _IDENTITIES


def policy_sha256() -> str:
    """Bind receipts to the actual implementation, not just a version label."""
    return hashlib.sha256(Path(__file__).read_bytes()).hexdigest()


def _path_key(value: str) -> str:
    # Only path representation is reconciled.  No suffix/basename matching,
    # checkout-to-retail aliasing, or '..' resolution is used to find a source.
    value = re.sub(r"[\\/]+", "/", value)
    windows = bool(re.match(r"^[A-Za-z]:/", value)) or value.startswith("//")
    return value.casefold() if windows or os.name == "nt" else value


def _filename(raw: bytes) -> str:
    """Decode GNU CPP filename-string quoting without evaluating C source."""
    value = bytearray()
    i = 0
    while i < len(raw):
        char = raw[i]
        if char != 92:
            value.append(char)
            i += 1
            continue
        i += 1
        if i >= len(raw):
            raise InputOriginError("Truncated CPP filename escape")
        char = raw[i]
        if char in (34, 92):
            value.append(char)
            i += 1
        elif 48 <= char <= 55:
            end = i + 1
            while end < min(i + 3, len(raw)) and 48 <= raw[end] <= 55:
                end += 1
            number = int(raw[i:end], 8)
            if number > 255:
                raise InputOriginError("Out-of-range CPP filename octal escape")
            value.append(number)
            i = end
        else:
            raise InputOriginError("Unsupported CPP filename escape")
    if any(c < 32 or c == 127 for c in value):
        raise InputOriginError("Control byte in CPP filename")
    try:
        return bytes(value).decode("utf-8")
    except UnicodeDecodeError as error:
        raise InputOriginError("CPP filename is not valid UTF-8") from error


def _advance_literal_state(line: bytes, state: tuple[bool, int | None, bool]):
    """Do not mistake marker-looking text in retained comments/literals for CPP."""
    block, quote, escaped = state
    i = 0
    while i < len(line):
        char = line[i]
        pair = line[i:i + 2]
        if block:
            if pair == b"*/":
                block = False
                i += 2
            else:
                i += 1
        elif quote is not None:
            if escaped:
                escaped = False
            elif char == 92:
                escaped = True
            elif char == quote:
                quote = None
            i += 1
        elif pair == b"/*":
            block = True
            i += 2
        elif pair == b"//":
            break
        elif char in (34, 39):
            quote = char
            i += 1
        else:
            i += 1
    return block, quote, escaped


def rewrite_main_input(root: Path, source: Path, input_bytes: bytes, *,
                       expected_source_sha256: str | None = None
                       ) -> tuple[bytes, dict | None]:
    """Return canonical-main CPP input and a reproducible origin receipt.

    Unknown TUs are byte-for-byte no-ops.  For declared TUs, the first real CPP
    marker must name the full physical main source.  Only markers naming that
    physical source are changed, including later returns from header includes.
    Existing canonical source #line markers are already correct and untouched.

    expected_source_sha256 is the caller's pre-CPP source digest.  It detects
    source changes across preprocessing; it is not proof that arbitrary cached
    bytes were freshly preprocessed.  That remains the producer's obligation.
    """
    if not isinstance(input_bytes, bytes):
        raise TypeError("input_bytes must be bytes")
    root = Path(os.path.abspath(root))
    source = Path(source)
    source = Path(os.path.abspath(source if source.is_absolute() else root / source))
    try:
        relative = source.relative_to(root).as_posix().casefold()
    except ValueError:
        return input_bytes, None
    canonical = _IDENTITIES.get(relative)
    if canonical is None:
        return input_bytes, None
    try:
        real_root = root.resolve(strict=True)
        physical = source.resolve(strict=True)
        physical.relative_to(real_root)
        source_data = physical.read_bytes()
    except (OSError, ValueError) as error:
        raise InputOriginError("Declared main source is missing or escapes the root") from error
    source_sha = hashlib.sha256(source_data).hexdigest()
    if expected_source_sha256 is not None:
        if not _SHA256.fullmatch(expected_source_sha256):
            raise InputOriginError("Invalid expected source SHA256")
        if expected_source_sha256 != source_sha:
            raise InputOriginError("Main source changed or the source digest is stale")
    physical_key = _path_key(physical.as_posix())
    canonical_key = _path_key(canonical)
    replacements = []
    state = (False, None, False)
    offset = 0
    bound = False
    for line_number, line in enumerate(input_bytes.splitlines(keepends=True), 1):
        body = line.rstrip(b"\r\n")
        is_code = not state[0] and state[1] is None
        marker = _MARKER.fullmatch(body) if is_code else None
        if is_code and _MARKER_START.match(body) and marker is None:
            raise InputOriginError("Malformed CPP line marker")
        if marker is None:
            state = _advance_literal_state(line, state)
            offset += len(line)
            continue
        filename = _filename(marker["filename"])
        flags = [int(value) for value in marker["flags"].split()]
        key = _path_key(filename)
        if filename not in _VIRTUAL_CPP_FILES:
            if not bound:
                if key != physical_key or 1 in flags:
                    raise InputOriginError("First real CPP marker does not bind the physical main source")
                bound = True
            elif int(marker["number"]) == 0 and not flags and key not in (physical_key, canonical_key):
                raise InputOriginError("Ambiguous second main-source binding")
        if key == physical_key:
            if 1 in flags:
                raise InputOriginError("Physical main source also appears as a nested include")
            start, end = marker.span("filename")
            replacements.append({"line": line_number, "filename_start": offset + start,
                                 "filename_end": offset + end,
                                 "cpp_line": int(marker["number"]), "flags": flags,
                                 "original_filename": filename})
        offset += len(line)
    if not bound or not replacements:
        raise InputOriginError("No physical main-source marker was bound and changed")
    out = bytearray()
    cursor = 0
    replacement = canonical.encode("ascii")
    for row in replacements:
        out.extend(input_bytes[cursor:row["filename_start"]])
        out.extend(replacement)
        cursor = row["filename_end"]
    out.extend(input_bytes[cursor:])
    output = bytes(out)
    manifest = {"schema": 1, "policy": POLICY_NAME, "policy_version": POLICY_VERSION,
                "policy_sha256": policy_sha256(), "source": relative,
                "physical_main": physical.as_posix(), "canonical_main": canonical,
                "source_sha256": source_sha,
                "input_sha256_before": hashlib.sha256(input_bytes).hexdigest(),
                "input_sha256_after": hashlib.sha256(output).hexdigest(),
                "replacement_count": len(replacements), "replacements": replacements,
                "expected_source_sha256": expected_source_sha256}
    return output, manifest
