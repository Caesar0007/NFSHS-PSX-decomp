#!/usr/bin/env python3
"""w66-a1 -- THE PER_FN_BRANCH_RETARGET MECHANISM, as a pure TEXT TRANSFORM of
tools/build.py.

`patched_source()` returns the exact text `branch_retarget.patch` produces, so
the probe harness (br.py) and the delivered patch are the SAME code by
construction -- there is no "probe drifted from the spec" failure mode.

tools/build.py is NEVER written by anything in this directory.
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
BUILD = ROOT / 'tools' / 'build.py'

# --------------------------------------------------------------------------
# 1. the mechanism itself (inserted immediately before PER_FN_PROLOGUE_UNSINK,
#    i.e. directly after _apply_text_moves -- its sibling)
# --------------------------------------------------------------------------
MECH = '''# w66-a1: PER_FN_BRANCH_RETARGET -- the PER_FN_TEXT_MOVES sibling that plants a
# FRESH label after a matched line and re-points ONE matched branch at it.
# It REMOVES NOTHING: strictly safer than `drop_after`, whose delay-slot
# deletion silently changed semantics on Camera_UpdateHeliCam (w63-a11 landed
# the deletion, w65-a2 found the branch still aimed past the deleted copy --
# a live correctness defect behind a green gate).  Here the word stream is
# untouched apart from the ONE retargeted branch's own 16-bit offset.
#
# WHY IT EXISTS (w65-a2 4.2, w65-a4 4.1): retail's `.s` routinely carries TWO
# labels ONE WORD APART and sends different branches to each, while cc1 emitted
# a SINGLE label all of them share (or the inverse, where cc1 threaded a branch
# retail did not).  A label MOVE cannot express that -- moving the shared label
# repairs one branch and breaks every other user of it.  Planting a second
# label at the wanted address and re-pointing exactly one branch does.
#
# Each row:
#   {"branch": regex matching EXACTLY ONE line in the .ent/.end region; its
#              single `$L<n>` operand is rewritten to the fresh label,
#    "after":  regex matching EXACTLY ONE line; the fresh label is inserted
#              immediately after that match}
# Both match counts are asserted == 1 (the w62/w64 anchor law).  A row that
# does not match exactly once is SKIPPED with a stderr line -- never applied
# partially, never silently.  Anchors must be label-number agnostic (`$L\\d+`)
# because any TU reorder renumbers every `$L`.
#
# Runs AFTER _apply_text_moves in every lane, so anchors are written against
# the POST-move text.
PER_FN_BRANCH_RETARGET = {
}

_BR_RETARGET_SEQ = [0]


def _apply_branch_retarget(rel_posix: str, s_file: Path) -> None:
    table = PER_FN_BRANCH_RETARGET.get(rel_posix)
    if not table:
        return
    txt = s_file.read_text(errors="replace")
    changed = False
    for name, rows in table.items():
        m = re.search(r"^\\t\\.ent\\t%s\\b[^\\n]*\\n" % re.escape(name), txt, re.M)
        if not m:
            continue
        m2 = re.search(r"^\\t\\.end\\t%s[ \\t]*$" % re.escape(name), txt[m.end():], re.M)
        end = m.end() + (m2.start() if m2 else 0)
        region = txt[m.start():end]
        before = region
        for row in rows:
            brs = list(re.finditer(row["branch"], region))
            ans = list(re.finditer(row["after"], region))
            if len(brs) != 1 or len(ans) != 1:
                sys.stderr.write("[branch_retarget] %s %s: branch x%d after x%d"
                                 " -- ROW SKIPPED\\n"
                                 % (rel_posix, name, len(brs), len(ans)))
                continue
            br, an = brs[0], ans[0]
            if br.start() < an.end() and an.start() < br.end():
                sys.stderr.write("[branch_retarget] %s %s: branch/after overlap"
                                 " -- ROW SKIPPED\\n" % (rel_posix, name))
                continue
            _BR_RETARGET_SEQ[0] += 1
            lab = "$L%d" % (966000 + _BR_RETARGET_SEQ[0])
            if lab in txt:
                sys.stderr.write("[branch_retarget] %s %s: label %s collides"
                                 " -- ROW SKIPPED\\n" % (rel_posix, name, lab))
                continue
            newbr, nsub = re.subn(r"\\$L\\d+", lab, br.group(0))
            if nsub != 1:
                sys.stderr.write("[branch_retarget] %s %s: branch line has %d"
                                 " $L operands -- ROW SKIPPED\\n"
                                 % (rel_posix, name, nsub))
                continue
            labline = lab + ":\\n"
            ins = an.end()
            if br.end() <= ins:
                region = (region[:br.start()] + newbr + region[br.end():ins]
                          + labline + region[ins:])
            else:
                region = (region[:ins] + labline + region[ins:br.start()]
                          + newbr + region[br.end():])
        if region != before:
            txt = txt[:m.start()] + region + txt[end:]
            changed = True
    if changed:
        s_file.write_text(txt)


'''

ANCHOR = ('# w53-a10: PROLOGUE UNSINK -- sched2 sinks a callee-saved save (zero\n'
          '# dependents => lowest priority) below the first body insns; retail sank only\n')

CALL_OLD = '    _apply_text_moves(rel.as_posix(), s_file)\n'
CALL_NEW = ('    _apply_text_moves(rel.as_posix(), s_file)\n'
            '    _apply_branch_retarget(rel.as_posix(), s_file)\n')


def _crlf(s):
    return s.replace('\n', '\r\n')


def patched_source(src=None):
    if src is None:
        src = BUILD.read_text(newline='')
    mech, anchor = _crlf(MECH), _crlf(ANCHOR)
    assert src.count(anchor) == 1, 'PROLOGUE_UNSINK anchor count != 1'
    src = src.replace(anchor, mech + anchor, 1)
    call_old, call_new = _crlf(CALL_OLD), _crlf(CALL_NEW)
    n = src.count(call_old)
    assert n == 3, '_apply_text_moves call sites = %d, expected 3' % n
    src = src.replace(call_old, call_new)
    return src


if __name__ == '__main__':
    out = patched_source()
    import ast
    ast.parse(out)
    print('OK: patched build.py parses; %d bytes (+%d)'
          % (len(out), len(out) - len(BUILD.read_text(newline=''))))
