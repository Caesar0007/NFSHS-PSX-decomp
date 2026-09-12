# P908 SimpleMem source-context investigation

Read-only evidence; no source/header/tool/build changes or compiler probes were
performed by this investigator. No padding constructor or invented helper is
proposed.

## Useful new independent twin

The mobile NFS4-derived corpus contains a real out-of-line form of the tagged
constructor and destructor:

- `C:/Temp/nfs4-clean/nfs4-mobile/nfs4-mobile-IDA.c:141512`:
  sub_5100E9 is the Track_Init counterpart. It allocates12 bytes and calls
  sub_5108E0 with receiver, `"Track_mem"`, filesize+45184 (0xB080; PSX uses0x9080).
- `:141712`, sub_5108E0: heap=allocator(tag,size), freeMem=heap;
  if(!heap) size=0; freeMemSize=size; return receiver.
- `:141732`, sub_510960: purge(heap); freeMem=0. This independently matches the
  native SimpleMem destructor expansion and the12-byte field layout.

**Raw verified, not merely trusted from IDA.** `mobile_raw.json` disassembles the
actual `[20050517] 2.11.0 [Windows]/nfsu2.exe` PE bytes. At51019D the caller pushes
the size,51019E pushes the string address600468,5101A3 sets ECX to the receiver,
and5101A9 calls5108E0. Constructor stack slots are `[ebp+8]`=tag,
`[ebp+0xc]`=size, and `ret8` confirms two explicit constructor parameters.

An important IDA arity omission was exposed: constructor5108E7 pushes a third
literal0 before size and tag, then calls allocator4C7DA1 and cleans12 bytes.
The decompiler printed only two allocator arguments. The **raw body therefore
agrees with PSX's allocator(tag,size,0)**, not a presumed two-argument API.
The raw store/null-test sequence confirms the two pointer members and INT size.

This strongly supports a **tag-first, size-second used constructor form** in the
shared source lineage. It does not recover the tag formal's original identifier
or prove an unused overload/default argument on PSX.

## What the native SYM/raw actually establish

- SimpleMem STRTAG346435, EOS34648c:12 bytes.
- MOS34644c heap:PTR VOID at0;34645e freeMem:PTR VOID at4;
  346473 freeMemSize:INT at8.
- Native standalone method identities: Alloc, FeignAlloc, ResizeToFit.
- Track_Init records36f366..36f6e2 contain the constructor-like inlined region.
  Record36f491 identifies `size` as INT in s1, in the nested block beginning
  36f488 and ending36f4b5 at800BA8C4. Native instructions800BA890..800BA8CC
  allocate12 bytes, call reservememadr("Track_mem",size,0), assign heap/freeMem,
  zero size on allocation failure and store freeMemSize before publishing Track_mem.
- There is **no explicit SimpleMem constructor signature**, **no SimpleMem `this`
  local record in Track_Init**, and no recovered SIMPLEMEM.H source path/body in
  these records. The source comment saying “SYM-proven inline constructor” is
  justified as a strong structural interpretation, not a fully recovered inline
  declaration or formal-name list. Native `this` records later in Track_Init
  refer to SerializedGroup/Group, not SimpleMem.

Full native records, SLD-tagged raw16-instruction region, hashes and copied
independent twin bodies are in `evidence.json`.

## The missing prefix is real; its exact source emitter is still unproved

The native bytes at800556C4 are `SimpleMem\0` plus two alignment zeros, followed
by Audio's strings at800556D0/800556EC. Root's ASPSX2.77 fixture proves that the
four-byte table difference is not resolved by a simple assembler padding change.
Root's separate compiler-context fixture establishes:

- an unused default-argument declaration alone emits no literal;
- an unused inline body containing the literal can emit it without function code.

That is a credible mechanism for a missing shared header body. However, adding
**any** uncalled method containing the string would exploit the same mechanism.
The mechanism alone does not establish which original method/overload existed,
its parameter names, or the original include graph into AudioCmn.

The mobile tagged constructor body has no default `"SimpleMem"` literal.
An uncalled overload might have been stripped there, so absence is not a proof
against the hypothesis—but it also does not authorize writing that overload.

## Searches and provenance limits

- Regular NFS4 PC decompilation/JEB bodies and NFS2 matched source supplied no
  SimpleMem/Track_mem text hit. The existing pcmap/map_a12.txt:218 also marks
  regular-PC Track_Init unresolved/PSX-asset-specific; that map is corroborating
  prior analysis, not primary proof. The mobile branch was the productive twin.
- Searched local NFS3 source/header/text and ps1-decomp-refs C/C++ sources and
  headers supplied no SimpleMem definition.
- `C:/Temp/export/NFSHSX-master/GAME/COMMON/SIMPLEMEM.H` is **not an original EA
  header**: it contains three generated extern declarations, and the project's
  README credits ThisDust decompilation. Its CPP labels itself decompiled code.
- `C:/Temp/claud/generated_headers_v3/simplemem.h` explicitly says generated
  from SYM; reconstructed_headers/tree's version is a flattened reconstruction.
  Neither independently recovers the missing constructor body.

## Recommended narrow continuation

Use the mobile raw tagged-constructor/dtor pair as independent semantic evidence
when revisiting Track_Init's existing expanded constructor. Keep tag-first/size-
second order and allocator's third zero argument. Do not invent the formal name.
For the Audio prefix, the next decisive evidence would be an actual called default
SimpleMem constructor variant, an original header, or another symbol-bearing
engine build exposing that unused inline body. Until then keep the header-emitter
hypothesis explicit; do not claim the gap is source-restored by inserting a dummy
inline constructor solely because its unused string produces the desired layout.
