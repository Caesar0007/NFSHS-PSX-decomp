# P882: GP audit, section bookkeeping and native source-data ownership

This round remains uncommitted. It improves source fidelity and link layout;
it does not declare the full executable or original-source goal complete.

## Exhaustive before/after results

| Metric | P881 baseline | Section accounting only | Native five-owner transfer |
| --- | ---: | ---: | ---: |
| GP-relative relocations checked | 2,381 | 2,381 | 2,381 |
| True signed-16 overflows | 324 | 0 | 0 |
| Target addresses different from retail | 1,696 | 1,696 | 1,462 |
| Previously correct targets regressed | — | 0 | 0 |

The earlier statement of ten truncations described the linker's printed error
lines, not the total: it explicitly omitted further diagnostics. The complete
audit resolves every site in 78 live TUs and checks the actual linked immediate.
The native GP is independently established by 1,867 raw/MAP references. Three
FIRST-library cases use non-retail GP addressing for an absolute slot; they
are explicitly covered by independent raw absolute-pair proof, not forced
function alignment. See BASELINE_RECEIPT_20260906.md and baseline_complete.json.

tools/gen_ld.py previously recorded fragment membership by object only. A
selected .data section accidentally suppressed the same TU's .sdata, which
then landed after .bss. Membership is now (object, section), including the
P881 credits owner. This fixes the omission, but in-range addresses alone are
not native addresses. section_accounting_complete.json preserves that negative
control: all overflows disappear while every wrong native target remains.

## Five proven source sections now occupy native slots

| Owner | Native base | Source bytes | Oracle reserved bytes |
| --- | --- | ---: | ---: |
| Hudpmx | 8013C84C | 1,333 | 1,336 |
| CopSpeak | 8013D07C | 126 | 128 |
| NFS3 | 8013D270 | 88 | 88 |
| R3DCar | 8013D324 | 156 | 156 |
| Sim | 8013D40C | 40 | 40 |

Each has independent raw/MAP anchors and a complete byte-exact, relocation-free
source payload. The other five omitted sections are not blindly promoted:
Textsys/snddata differ in payload, Track has conflicting packing/base evidence,
and two others lack a sufficient anchor. Their work remains open.

The five raw owner runs are separate oracle-only files. Src retains them;
recon selects the typed source sections in the ordered sdata fragment and
excludes the raw copies. Exact sizes/hashes are fail-closed in the ownership
registry. Fragment membership is checked against real parsed selectors, not
the registry's own seeded entries; no second explicit output section consumes
these fragment-owned sections. P881 credits stays a separate anchored owner.

Baseline raw, new src and new recon isolated links each reproduce all 2,692
bytes of the checked windows, including unchanged neighbors. The original
three- and two-byte zero-padding gaps are preserved by SUBALIGN(4); adjacent
symbols retain native addresses. All 406 src labels and 200 shared recon
labels preserve their addresses. See OWNERSHIP_LANDING_20260907.md and the
ownership_window/label receipts. No code or raw payload was rewritten.

The retained raw Hudpmx pointer tables reference 34 legacy string labels.
Existing linker metadata now PROVIDEs those names at the validated source
string addresses, allocating no storage. Each label is checked against the
original raw object's offset and every actual table reference is checked
against ROM; repeated pointer-table entries are not assumed to be sequential.
The typed strings remain the only selected source owner, and those raw pointer
references no longer become undefined when the old raw string copy is excluded.

verify_production_owners.py confirms the actual generated map/source sections,
padding, excluded inputs and legacy pointer references. The complete after
audit proves 234 native target addresses restored with zero previously correct
targets regressing. compare_current.py reuses the frozen proven expectations
only when every input relocation identity/symbol/addend still agrees.

## Limits and validation

The generated diagnostic ELF still has overlapping output sections, including
an oversized .data range over .sdata. Owner-byte checks select the actual owner
section and explicitly record overlaps; this must not be reported as a valid
flat final image. There remain 1,462 wrong-but-in-range targets and a .sbss
PROGBITS warning. The standing gate's known blob duplicates fall 963->912;
REAL duplicates, phantoms and referenced unresolveds remain zero. Zero overflow
and zero undefined names do not close these other integration obligations.

full_validation.py runs all three full builds, source/oracle data-window checks,
the current native-owner check, exhaustive GP recount, standing link gates,
151-function frontend regression and source/vtable policies. Its completed JSON
is authoritative; a partial log is not a PASS. Protected tool/linker/raw backups
are kept beside these receipts and in ownership_backups/.

Concurrent source improvements: six false array views removed in fescreen,
femenuoptions and fedialog; dst removed and genuine NumberOfRows[6] moved out
of an artificial block without changing initializer timing. All three whole
objects remain byte-identical (151/151 functions PASS). The fedialog scalar
ticks attempt failed and was fully restored; it is not a retained regression.

No new source names/helpers, asm/volatile, compiler flag or post-compiler
instruction rewrite was introduced. The full source/SYM/SLD goal remains active.
