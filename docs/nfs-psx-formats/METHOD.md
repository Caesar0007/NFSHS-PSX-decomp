# Method

## Confidence tags (every field in a `formats/` doc carries one)
| Tag | Meaning |
|-----|---------|
| ★★★ | A loader reads it: cited function + VA (matched/reconstructed source or raw disasm), **or** proven arithmetically across a sample census |
| ★★ | Structure determined from samples + partial code; some inner records unexplained |
| ★ | Hypothesis from sample inspection or a third-party spec only |
| ✗ | Refuted — keep the entry, say what disproved it (prior specs were wrong several times: DCT "MDEC raw", GEO "pre-relocated image", GRP chunk header 64→48 b) |

## Workflow for one format family
1. **Census** — collect every instance across all titles/regions/betas; record magic, size, count,
   filename grammar. A format is not understood until the census has no unexplained members.
2. **Find the loader** — grep the code oracle for the filename, extension, or magic
   (NFS4: SYM names + byte-matched source; NFS2: PC-beta `nfsw.exe` named loaders; NFS3/NFS1:
   reconstructed/Ghidra trees). Record `function @ VA` for every field it touches.
3. **Structure** — derive layout from the loader, not from the bytes. Bytes confirm; code decides.
4. **Validate** — a round-trip decoder/encoder over the full census (byte-identical re-encode is
   the gold standard), or an emulator-in-the-loop check (PCSX-Redux savestate + Lua) for
   formats only meaningful at runtime.
5. **Lineage** — compare with the same family in the neighbouring titles; write the per-game
   delta table. Betas pin down *when* a field appeared.
6. **Write it up** in `formats/<FAMILY>.md` using the template below.

## Authority order (when sources disagree)
loader code (raw disasm > matched source > Ghidra/IDA) › census arithmetic › LibOpenNFS / community
specs › earlier notes of ours. The NFS4 matching repo's rules on args/signedness apply unchanged
when reading loader code.

## Tooling conventions
- Tools live in `docs/nfs-psx-formats/tools/` (Python 3, no game data embedded); runtime probes in
  `tools/runtime/` (see its README). Reference data comes from `tools/psx_iso.py` extractions of
  retail images, never from older extraction folders.
- Test vectors: tiny synthetic files only; real samples referenced by path + SHA1, never committed.

## `formats/<FAMILY>.md` template
```
# <FAMILY> — <one-line purpose>
Games: NFS1 ? | NFS2 ? | NFS3 ? | NFS4 ? | NFS5 ?      Magic / extension: ...
Loader(s): <game>: <function> @ <VA>
## Layout (canonical title) — table: offset | type | field | tag | note
## Per-game deltas — table: game/build | difference | evidence
## Census — counts, sizes, oddities
## Tools — decoder/encoder paths, round-trip status
## Open questions
```
