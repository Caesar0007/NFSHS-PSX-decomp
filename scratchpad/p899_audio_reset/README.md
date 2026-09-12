# P899 Reset: native loops and exact instruction-line partitions

The retained actual source keeps all 56 instruction words and every branch
unchanged. Both existing `i` locals now have their exact native scope ranges,
depths, types and register homes. All seven emitted nonempty blocks match
native order and ownership. Native has nine blocks: two empty records at
8007C6A0, 1be9fc/1bea05, still lack an established original inline identity.

The first loop becomes a scoped `for (int i...)`; the second uses a scoped
for-loop with the existing captured element cursor. Removing the redundant
void return completes the native line grouping. No new name, helper, qualifier,
asm, volatile, compiler flag, or output rewrite is introduced.

| Stage | Code | Native SLD merge/split pairs | Exact native i owners |
|---|---|---:|---:|
| before |56/56 PASS |20/60 |0/2|
| first_for |56/56 PASS |20/56 |1/2|
| both_for |56/56 PASS |0/42 |2/2|
| no_return |56/56 PASS |0/0 |2/2|

All retained steps preserve the whole normal object and introduce no new bad
SLD pair. The full raw proof covers 56 words, including nine relocated references
resolved in verification memory only. Native body SHA256 is
`6d94686ac21b9a9352502db6faa1fc01f0597e6ea0ea5951e9e4d882ac8086c7`.

## The se name remains open

No original name or distinct original C source object has been proved for the
existing `se`. Its prior SOURCE-RECOVERY-OPEN note is retained, not replaced
by an exemption. Exact SLD partitions and the two native local records do not
establish that this extra source spelling was original.

The source-only indexed probes were frozen and rejected:

- Keeping the old loop control and indexing native members: 62/56, 38 differences.
- A byte-addressed header base with the same indexing: the same 62/56 result.
- A natural indexed for-loop: 58/56, 32 differences, reproducing the previous
  result with fresh P898 context. All five neighbors remained PASS.

The differences are concrete: the indexed form refreshes gGameAudioList and
uses that updated base for its next indexed address. Retail keeps a separate
captured element cursor while reloading the list pointer for the loop bound.
The indexed form therefore adds address arithmetic, not merely register noise.

## Compiler evidence and its limit

Actual CC1PLPSX -da traces were generated for the passing pointer form and the
failing for-index form. Each diagnostic object is literally identical to its
no-dump control. No optimization flag or compiler version was changed.

In the indexed loop, RTL register106 receives gGameAudioList again at insn121;
the next element address derives from that register plus the running index.
Stores are mem/s:HI at insn145 and mem/s:QI at163. The 2.8.1 source's
loop.c:2738 invariant_p checks true_dependence against all loop stores;
sched.c:830 explicitly excludes QImode stores from its dynamic-struct versus
fixed-scalar no-alias exception. This is consistent with the observed byte-store
dependence; it is not a claim that an internal compiler callback was instrumented.
The /v on SYMBOL_REF is not a volatile MEM qualification.

This evidence directs further work toward the original list-access/capture
construct, not an invented const/restrict declaration, a wider store, or a fake
macro. It does not prove the source pointer/name unavoidable or constitute a
floor. The unknown inline identity and source name remain active questions.

## Combined actual source

Candidate/landed stages combine this Reset change with the independently checked
P899 SoundTrack proposal. The checker uses that accepted SoundTrack contract,
while all other neighbors retain their previous contracts. Natural compiler label
renumbering in AddCustomObject is checked by resolving each existing SCL6 source
label to its actual instruction PC; no labels are modified in emitted output.

See landed_verification.json, landed_raw_target_receipt.json and the independent
../p899_audio_landed_20260912/combined_verification.json. The parent
../p899_checkpoint contains complete source/object/link regression results.
