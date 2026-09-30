"""Compare linked native/retail SYM SLD records for every common function.

This reads existing dumps and writes only a JSON diagnostic, not a build or a
claim that those dumps reflect today's source. Refresh the native debug lane (or
fail-closed symloop TUs) and verify linked bytes before treating a result as
current. No compiler output or post-recompile instruction rewriting occurs.

Unlike symtree_cmp.py, this checks instruction-line tags, block-line records,
and the function-end line delta. The per-word tag lookup follows sldprobe.py:
each instruction inherits the most recent SLD line event at or before its VA.
"""

import argparse
import bisect
import json
import re
from collections import Counter
from pathlib import Path

from retail_sym import txt as retail_sym_text


ROOT = Path(__file__).resolve().parents[2]
REC = re.compile(r"^[0-9a-fA-F]+: \$([0-9a-fA-F]{8}) ([0-9a-fA-F]{1,2}) (.*)$")
HEADER = re.compile(r"^\s+(\w+) = (.*)$")
LINE = re.compile(
    r"(?:Inc SLD linenum.*\(to (\d+)\)|Set SLD linenum to (\d+)"
    r"|Set SLD to line (\d+) of file)"
)
BLOCK_LINE = re.compile(r"line = (\d+)")
END_LINE = re.compile(r"\bline\s+(\d+)")


def parse_dump(path):
    """Read function bounds/line records and the linked SLD event table."""
    funcs = {}
    events = {}
    current = None
    header = False
    duplicates = []
    with open(path, errors="replace") as stream:
        for line in stream:
            m = REC.match(line)
            if not m:
                if current is not None and header:
                    h = HEADER.match(line)
                    if h:
                        key, value = h.group(1), h.group(2).strip()
                        current["hdr"][key] = value
                        if key == "name":
                            header = False
                            name = value
                            if name.startswith("___"):
                                name = "_._" + name[3:]
                            current["name"] = name
                            if name in funcs:
                                duplicates.append(name)
                            else:
                                funcs[name] = current
                continue
            address, kind, body = int(m.group(1), 16), m.group(2).lower(), m.group(3)
            if kind in ("80", "82", "86", "88"):
                sld = LINE.search(body)
                if sld:
                    events[address] = int(next(value for value in sld.groups() if value))
            if kind == "8c":
                current = {"start": address, "end": None, "end_line": None,
                           "hdr": {}, "blocks": []}
                header = True
            elif current is not None and kind == "8e":
                current["end"] = address
                end = END_LINE.search(body)
                current["end_line"] = int(end.group(1)) if end else None
                current = None
                header = False
            elif current is not None and kind in ("90", "92"):
                block = BLOCK_LINE.search(body)
                current["blocks"].append((kind, address - current["start"],
                                          int(block.group(1)) if block else None))
    keys = sorted(events)
    return funcs, keys, events, sorted(set(duplicates))


def end_delta(fn):
    """Some PsyQ records store end lines relative, others absolute."""
    if fn["end_line"] is None:
        return None
    header_line = int(fn["hdr"]["line"])
    return fn["end_line"] - header_line if fn["end_line"] >= header_line else fn["end_line"]


def directory_of(file_name):
    normalized = file_name.replace("/", "\\").upper()
    match = re.search(r"\\(GAME|FRONTEND)\\(COMMON|PSX)\\", normalized)
    return "/".join(match.groups()) if match else "OTHER"


def line_at(keys, events, address):
    index = bisect.bisect_right(keys, address) - 1
    return events[keys[index]] if index >= 0 else None


def compare_function(native, retail, native_keys, native_events,
                     retail_keys, retail_events, max_examples=12):
    n_start, n_end = native["start"], native["end"]
    r_start, r_end = retail["start"], retail["end"]
    result = {"native_words": None, "retail_words": None,
              "tag_diffs": None, "tag_examples": [],
              "block_lines_equal": native["blocks"] == retail["blocks"],
              "native_end_delta": end_delta(native),
              "retail_end_delta": end_delta(retail)}
    result["end_line_equal"] = (result["native_end_delta"] is not None
                                and result["retail_end_delta"] is not None
                                and result["native_end_delta"] == result["retail_end_delta"])
    if n_end is None or r_end is None or n_end <= n_start or r_end <= r_start:
        result["status"] = "INVALID_BOUNDS"
        return result
    if (n_end - n_start) % 4 or (r_end - r_start) % 4:
        result["status"] = "UNALIGNED_BOUNDS"
        return result
    n_words, r_words = (n_end - n_start) // 4, (r_end - r_start) // 4
    result["native_words"], result["retail_words"] = n_words, r_words
    if n_words != r_words:
        result["status"] = "LENGTH_MISMATCH"
        return result
    # Inheriting a previous module's last line is not evidence that this
    # function has SLD coverage. Require an event within each function span.
    n_event_index = bisect.bisect_left(native_keys, n_start)
    r_event_index = bisect.bisect_left(retail_keys, r_start)
    if (n_event_index == len(native_keys) or native_keys[n_event_index] >= n_end
            or r_event_index == len(retail_keys) or retail_keys[r_event_index] >= r_end):
        result["status"] = "NO_FUNCTION_SLD_EVENT"
        return result
    n_header, r_header = int(native["hdr"]["line"]), int(retail["hdr"]["line"])
    diffs = 0
    for word in range(r_words):
        n_line = line_at(native_keys, native_events, n_start + word * 4)
        r_line = line_at(retail_keys, retail_events, r_start + word * 4)
        if n_line is None or r_line is None:
            result["status"] = "NO_SLD_EVENT"
            return result
        n_rel, r_rel = n_line - n_header, r_line - r_header
        if n_rel != r_rel:
            diffs += 1
            if len(result["tag_examples"]) < max_examples:
                result["tag_examples"].append({"offset": word * 4,
                                                "native": n_rel, "retail": r_rel})
    result["tag_diffs"] = diffs
    result["status"] = ("EXACT" if not diffs and result["block_lines_equal"]
                        and result["end_line_equal"] else "DIFF")
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--native", default=str(ROOT / "build/psyq_g/nfs4_sym.txt"))
    parser.add_argument("--retail", default=str(retail_sym_text()))
    parser.add_argument("--report", default=str(ROOT / "build/psyq_g/sldtree_report.json"))
    parser.add_argument("--fn", help="print one full function result")
    parser.add_argument("--require-exact", action="store_true",
                        help="fail until every common function has exact SLD")
    args = parser.parse_args()
    native, n_keys, n_events, n_duplicates = parse_dump(args.native)
    retail, r_keys, r_events, r_duplicates = parse_dump(args.retail)
    # Cfront vague-linkage copies can have the same name in multiple objects.
    # Preserve symtree_cmp's first-definition coverage, but never certify its
    # arbitrarily chosen copy as SLD-exact without object-level disambiguation.
    ambiguous = set(n_duplicates) | set(r_duplicates)
    native_board_path = Path(args.native).with_name("symtree_report.json")
    native_board = (json.loads(native_board_path.read_text())
                    if native_board_path.exists() else {})
    functions = {}
    directories = {}
    for name in sorted(native.keys() & retail.keys()):
        n_fn, r_fn = native[name], retail[name]
        result = compare_function(n_fn, r_fn, n_keys, n_events, r_keys, r_events)
        if name in ambiguous:
            result["first_candidate"] = result["status"]
            result["status"] = "AMBIGUOUS_NAME"
            result["tag_diffs"] = None
            result["block_lines_equal"] = None
            result["end_line_equal"] = None
        result["file"] = r_fn["hdr"].get("file", "")
        result["directory"] = directory_of(result["file"])
        result["native_clean"] = (not native_board[name]["issues"]
                                  if name in native_board else None)
        functions[name] = result
        summary = directories.setdefault(result["directory"], Counter())
        summary["functions"] += 1
        summary[result["status"].lower()] += 1
        if result["tag_diffs"] == 0:
            summary["tag_exact"] += 1
        if result["block_lines_equal"]:
            summary["block_line_exact"] += 1
        if result["end_line_equal"]:
            summary["end_line_exact"] += 1
        if result["native_clean"] and result["status"] == "EXACT":
            summary["native_and_sld_exact"] += 1
        if result["retail_words"] is not None:
            summary["retail_words"] += result["retail_words"]
            if result["tag_diffs"] is not None:
                summary["tag_words_compared"] += result["retail_words"]
                summary["tag_diff_words"] += result["tag_diffs"]
    report = {"inputs": {"native": args.native, "retail": args.retail,
                         "native_board": str(native_board_path) if native_board else None},
              "coverage": {"native": len(native), "retail": len(retail),
                           "common": len(functions),
                           "duplicate_names": sorted(ambiguous),
                           "retail_only": sorted(retail.keys() - native.keys()),
                           "native_only": sorted(native.keys() - retail.keys())},
              "directories": {key: dict(value) for key, value in sorted(directories.items())},
              "functions": functions}
    output = Path(args.report)
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(report, indent=1) + "\n")
    print("common %d, retail-only %d, native-only %d" %
          (len(functions), len(report["coverage"]["retail_only"]),
           len(report["coverage"]["native_only"])))
    for directory, counts in sorted(directories.items()):
        print("%-18s %4d/%4d SLD-exact, %4d native+SLD, %7d/%7d tag diffs"
              % (directory, counts["exact"], counts["functions"],
                 counts["native_and_sld_exact"], counts["tag_diff_words"],
                 counts["tag_words_compared"]))
    if args.fn:
        print(args.fn, json.dumps(functions.get(args.fn), indent=1))
    if args.require_exact and any(fn["status"] != "EXACT" for fn in functions.values()):
        raise SystemExit(1)


if __name__ == "__main__":
    main()
