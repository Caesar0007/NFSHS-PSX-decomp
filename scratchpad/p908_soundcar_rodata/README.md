# P908 SoundCar readonly-layout investigation

Diagnostic work only. Production AudioCmn source, header and data placement
were not changed. The four-byte jump-table discrepancy remains open.

## Falsified assembler-padding explanation

The actual compiler emits the two readonly diagnostic strings, a 44-byte
TrackGenBank template, then `.align 3` before SoundCar's 12-entry switch table.
The source section begins with strings at offsets0 and28, template60 and
jump table104. Retail references the strings at800556D0/800556EC and template
at8005570C, but references the switch table at8005573C (offset108 fromD0).

Original PsyQ4.3 ASPSX2.77 was executed on two isolated assembler fixtures:
one has the intervening load/indirect-jump/section switch, the other only data.
Both produce offsets0/28/60/104 and a152-byte readonly section. Thus neither
this assembler's basic alignment nor a pending branch delay produces the
missing four bytes. No assembler workaround is justified by that hypothesis.

Anti-vacuity detail: this old assembler treated initial LF-only fixture text
as two lines and emitted empty objects without an error. The diagnostic files
were formatted as CRLF, then all expected exported labels, section extents,
payload and relocations were required. `fixture_results.json` is the nonempty
verified result; assembly exit status alone was not trusted.

## New source-context angle

Retail has `SimpleMem\0` at800556C4, with two following alignment bytes before
the first AudioCmn string. Including this real twelve-byte prefix changes the
natural object-relative positions to string12, string40, template72, switch120.
An object base556C4 then makes all four addresses agree, including switch5573C.
This is an alignment consequence of a possible missing header-emitted literal,
not evidence for a new four-byte C variable or manually inserted padding.

`context_results.json` tests two ordinary C++ compiler mechanisms:

- An unused default-argument declaration containing the literal emits no data.
- An uncalled inline constructor body containing the literal emits the ten-byte
  string without emitting constructor code.

The second mechanism is real, but the fixture's ProbeMemory class is explicitly
invented diagnostic code and must not be copied into the reconstruction.
It proves how an omitted inline header body could disturb the readonly layout,
not which original declaration existed.

Independent investigation in `../p908_simplemem_context/README.md` found the
mobile Track_Init/SimpleMem constructor twin and verified its raw instructions.
Its constructor is tag-first/size-second, and the allocator takes a third zero
argument omitted by IDA. This corroborates the used constructor's field stores.
It does not recover an unused `SimpleMem`-literal overload, the tag formal's
original name, or AudioCmn's original include context. Generated ThisDust and
SYM headers were rejected as independent original-source authority.

Next: seek the original unused inline body/header context (or additional sibling
evidence exposing it). Do not manufacture a literal-emitting constructor just
to achieve the desired bytes. All production code and the known gap are intact.
