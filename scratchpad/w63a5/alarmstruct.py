#!/usr/bin/env python3
"""Apply / revert the ALARM-AS-ONE-STRUCT shape to recon/syslib/psx/libcd/drv.c.

Sourced from the two matched sibling libcd decomps (see RECEIPTS.md):
  C:/Temp/ps1-decomp-refs/sotn-decomp/src/main/psxsdk/libcd/bios.c  (volatile Alarm_t Alarm)
  C:/Temp/rage-racer-decomp/src/main/PAL/lib/libcd/command_write.c  (((CdAlarm *)&g_CdTimeoutDeadline)->name)
Both model 0x801489B4/B8/BC as ONE 12-byte object; ours had three scalars.
The three externs are KEPT (link/data-blob ownership unchanged); the struct is a
VIEW at &D_801489B4, so every access is %hi/%lo(D_801489B4 + N) -- byte-identical
after link, and gate-invisible to verify_asm's %lo normalization.
"""
import os
import sys

REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
TU = os.path.join(REPO, "recon", "syslib", "psx", "libcd", "drv.c")

DECL_OLD = """extern int          D_801489B4;       /* deadline (VSync frame) */
extern int          D_801489B8;       /* spin counter */
extern const char  *D_801489BC;       /* current op name (debug) */"""

DECL_NEW = """extern int          D_801489B4;       /* deadline (VSync frame) */
extern int          D_801489B8;       /* spin counter */
extern const char  *D_801489BC;       /* current op name (debug) */
/* W63-A5: the three are ONE 12-byte alarm object.  Both matched sibling libcd
 * decomps model it that way (sotn-decomp psxsdk/libcd/bios.c `volatile Alarm_t
 * Alarm`; rage-racer-decomp libcd/command_write.c `((CdAlarm *)&g_CdTimeoutDeadline)
 * ->name`).  Kept as a VIEW so the three data symbols stay owned as-is. */
typedef struct { int deadline; int counter; char *name; } CD_alarm;
#define ALARM (*(CD_alarm *)&D_801489B4)"""

SUBS = [
    ("D_801489B4 = VSync(-1) + 0x3c0;", "ALARM.deadline = VSync(-1) + 0x3c0;"),
    ("D_801489B8 = 0;", "ALARM.counter = 0;"),
    ('D_801489BC = name;', 'ALARM.name = (char *)name;'),
    ('D_801489BC = "CD_sync";', 'ALARM.name = "CD_sync";'),
    ('D_801489BC = "CD_ready";', 'ALARM.name = "CD_ready";'),
    ('D_801489BC = "CD_cw";', 'ALARM.name = "CD_cw";'),
    ('D_801489BC = "CD_datasync";', 'ALARM.name = "CD_datasync";'),
    ("int c = D_801489B8;", "int c = ALARM.counter;"),
    ("D_801489B8 = c;", "ALARM.counter = c;"),
    ("if (D_801489B4 < VSync(-1)", "if (ALARM.deadline < VSync(-1)"),
    ("if (VSync(-1) > D_801489B4", "if (VSync(-1) > ALARM.deadline"),
    ('Ready=%s\\n", D_801489BC,', 'Ready=%s\\n", ALARM.name,'),
]


def main():
    txt = open(TU, "rb").read().decode("utf-8")
    assert txt.count(DECL_OLD) == 1, "decl anchor"
    out = txt.replace(DECL_OLD, DECL_NEW, 1)
    total = 0
    for old, new in SUBS:
        n = out.count(old)
        assert n >= 1, "missing anchor: %r" % old
        out = out.replace(old, new)
        total += n
    assert "D_801489B4 = " not in out and "D_801489B8 = " not in out
    tmp = TU + ".w63a5tmp"
    with open(tmp, "wb") as f:
        f.write(out.encode("utf-8"))
    assert os.path.getsize(tmp) > len(txt) // 2
    os.replace(tmp, TU)
    print("applied, %d use-site substitutions" % total)


if __name__ == "__main__":
    main()
