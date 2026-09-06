# P880 credits: scalar globals and native-only Draw locals

Removed A_ticks[] and A_screenMain[] asm-label overrides. The existing scalar
declarations from fecredits_externs.h now reach the same cells directly. Then
removed Draw's mainScreen caller alias and used screenMain->tvConfigs[i].
No new production name, helper, asm/volatile or compiler flag was introduced.

All seven functions PASS; no branch discrepancies. The entire object is
unchanged, including data and every relocation:

    a84ea3901e372b00286db36de01e45637d0a72bed38763c0aa27cef55766db70

Draw is 81/81 exact-g. The generated function now declares only this, selected
and i; native SYM's i is REG6 in its recorded loop scope. The direct loop's
anonymous 48-byte induction pointer no longer masquerades as a source local.
All 81 oracle comment words were read from the raw EXE and confirmed. This
plus whole-object identity preserves the accepted references; it is not
misreported as a separate new full-module raw link.

screenMain is native EXT PTR STRUCT tScreenMain at 80051E58, record605a62,
size1464. ticks is the native compact public symbol at8013DCAC, record019199;
its existing four-byte INT owner/declarations and signed source uses remain
unchanged. The compact NFS4 row alone is not a typed EXT declaration.

## Newly exposed missing declaration: lasttick

SetupCurrCredit's native record5f1f9a is STAT INT lasttick with value4,
an object-relative storage record. The current A_FECredits_lastFadeTick view
reaches blob cell D_80051AA4 but is not a function-local static declaration.
The earlier SYM-CARRIER:lasttick exemption hid this difference from the
missing-name total; it has been removed without changing compiled bytes.

The strict frontend report now correctly has one missing name and780 rather
than781 declaration-clean functions. This is an exposed pre-existing source
gap, not a matching regression. Restoring local static storage must also
reconcile object-relative data ownership and the existing blob/reference
layout; simply creating a second backing cell is not a valid repair.

The remaining source-only carriers, startTicksSnapshot volatile read and
private helper/source-shape uncertainties are still open. Backup:
fecredits.cpp.before. verify.py/receipts.json reproduce the landed result.
