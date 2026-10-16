# NFS4 non-SDK assembly: portable C counterparts

These files are **behavioral ports**, not replacement objects for the PSX
matching build. Nothing in `recon/`, `src/`, the linker, or SDK is replaced.
The public C API is [include/nfs4_eac_port.h](include/nfs4_eac_port.h).

Generated inventories, runtime receipts, search reports and build outputs are
local artifacts, not committed source. Paths under `verification/` below name
those local receipts; run the documented checks to regenerate them. The
2026-10-16 checkpoint reran all 4,542 comparisons and the separate 331-case
exact-variant check successfully, including full emulator-state restoration.

A separate [psx_match lane](psx_match/README.md) now pursues ordinary-C
byte matches without weakening these port contracts. Its two accepted entries
(`shapecount` and the shared null body) have exact linked text and independent
live runtime receipts. The other 22 matching entries remain open.
Compile the two `eaclib/*.c` files with a C11 compiler and link them into a
future host port. They use only fixed-width integers, standard memory routines,
and explicit little-endian access; there are no MIPS instructions, register
pins, compiler fences, or native-pointer-sized integer casts.

Standalone CMake build (tested with Ninja/GCC 15.2):

```powershell
cmake -S ports -B ports/build/cmake -G Ninja -DCMAKE_C_COMPILER=gcc
cmake --build ports/build/cmake
```

The target `nfs4_eac_port` is a static library; host applications can instead
add this directory to their own CMake build and link that target.

## Implemented whole assembly routines

| Retail routine(s) | Portable API | Observable contract |
|---|---|---|
| `blockfill`, `blockclear` | `nfs4_blockfill`, `nfs4_blockclear` | Low-byte fill; full destination and guards checked |
| `blockmove` | `nfs4_blockmove` | **Source, destination, count**; overlapping RAM copy |
| `fixedmult` / `rmult` | `nfs4_fixedmult` | Signed 16.16 product, positive `0x8000` round bias, low 32 result bits |
| `fixeddiv` / `rdiv` | `nfs4_fixeddiv` | Retail fractional recurrence; explicit trapping-SUB outcome |
| `fixedinverse` / `rinverse` | `nfs4_fixedinverse` | Raw DIVU zero behavior and arithmetic half-magnitude shift |
| `fixedsqrt` | `nfs4_fixedsqrt` | **Retail approximation table**, not mathematical `sqrt` |
| `random`, `seedrandom` | `nfs4_random`, `nfs4_seedrandom` | Exact six-word carry state, caller-owned context |
| `crc16` | `nfs4_crc16` | Retail `0xFBEA` initialization and table-equivalent recurrence |
| `getm`, `geti` | `nfs4_getm`, `nfs4_geti` | Big-endian branch-selected read / four-byte LE masked read |
| `make64`, `divu64` | `nfs4_make64`, `nfs4_divu64` | Masked MIPS shifts; exact division recurrence, not assumed uint64 division |
| `shapedepth` | `nfs4_shapedepth` | Format byte mask and depth selection |
| `shapecount`, `shapepointer`, `shapename` | `nfs4_shapecount`, `nfs4_shapepointer`, `nfs4_shapename` | Shape-file LE directory, unsigned bounds, four-byte name writes |
| `intsin` / `fastintsin`, `intcos` / `fastintcos` | `nfs4_intsin`, `nfs4_intcos` | Exact 257-entry table, 1024-unit period, uint32 angle wrapping |
| `initgp`, `savegp`, `restoregp` | Context-based `nfs4_*gp` | Explicit emulated GP context instead of meaningless host register stubs |
| 21 release aliases at `0x800F6114` | `nfs4_null_result` | Shared return-zero **body**; alias-specific caller signatures not invented |

The co-equal fixed-point/sine entries are source-level aliases in the header.
Names are prefixed to avoid collisions with host `random`, memory libraries,
and unchanged PSX functions. Return values represented as `uint32_t` are exact
register bit patterns, not promises that every mathematical result fits signed32.

## Contracts and limits

- Memory functions and CRC require nonnegative, valid counts and ordinary RAM
  buffers. The portable API does not preserve word-store bus transactions,
  MMIO effects, timing, or aligned padding reads of the optimized MIPS routines.
  All memory tests compare the entire initialized buffer, including guards.
- `geti` **always reads four bytes**, regardless of its count argument. `getm`
  reproduces the branch choices even for extreme int32 counts; callers must
  provide the corresponding readable bytes (four bytes are always sufficient).
- Shape accessors require a valid directory and in-buffer offsets. A native
  pointer cannot represent arbitrary wrapped PSX address arithmetic safely;
  malformed directories and offsets are not an accepted port domain.
- `nfs4_fixeddiv` returns `{bits, overflow}`. `overflow == 1` represents the
  retail signed-SUB exception; callers must handle it, not use `bits` as a normal
  return. Zero denominator returns zero as retail does. `nfs4_make64` returns
  one on its ADDI overflow domain and leaves output untouched. These exception
  outcomes are tested against the emulator's actual Cause code12.
- `fixedinverse(0)` is intentionally zero, unlike the existing unguarded host
  fallback. The `INT_MIN` arithmetic-shift case is intentionally preserved.
- `divu64` retains wrap-before-compare behavior for arbitrary initial registers.
  It must not be replaced by a conventional 64-bit quotient without a domain proof.
- The RNG state and GP context are explicit port objects. A host integration
  chooses their lifetime; there is no hidden singleton or fake host `$gp`.

## Real runtime comparison (already adapted toolset)

Accepted first-batch receipt:
[verification/eac-20260927-144440.json](verification/eac-20260927-144440.json).
It records **4,542 passing comparisons across 24 routine bodies**, including
24 explicit overflow exceptions, a full integer-sine period, 256 format bytes,
and full emulator-state restoration. The code covers all 14 executable whole
assembly blocks found in the non-SDK census, plus NULLFUNC's shared C body.
Co-equal labels are aliases of those bodies, not extra independent test passes.
This is a tested-domain receipt, not a universal-equivalence or full-game claim.

The NFS4 repository already adopted `C:/Temp/PSX-Dynamic-Decomp`'s patched
DuckStation and GDB/shared-RAM client under `tools/duckstation/`. This port
checker follows that project's `audit_actor_math.py` method, with **NFS4**
addresses and isolated port2350. It does not use Fighting Force addresses and
does not substitute a Python instruction model for runtime verification.

From `C:/Temp/nfs4-decomp`:

```powershell
# Only if no NFS4 test emulator is already running; other projects are untouched.
powershell -ExecutionPolicy Bypass -File tools/duckstation/launch.ps1 -FastBoot
python ports/tools/verify_eac_runtime.py --random-cases 64
python ports/tools/inventory_asm.py
python -m unittest discover -s ports/tools -p test_inventory.py
python ports/tools/verify_receipt.py ports/verification/eac-20260927-144440.json
```

`verify_receipt.py` checks artifact/source identity only. It does not rerun the
emulator and must not be used to claim new runtime coverage after a code change.

The checker:

1. Builds and loads the ordinary C code as a native DLL with GCC C11 and warnings
   as errors. The same sources are intended for other C11 hosts, not just Windows.
2. Verifies actual listener ownership and runtime path, then saves a **full**
   emulator state through the adopted Save/Load API before any injection.
3. Confirms each ASM oracle file matches the original `rom/nfs4-f.exe` bytes,
   injects those bytes/data into its own paused VM, and calls them with recorded
   deterministic fixtures. No retail instruction is rewritten.
4. Compares native returns, memory/state, GP effects, overflow exceptions, and
   callee-saved-register preservation. A final RAM check rejects writes outside
   the declared effects. Inputs cover alignments, overlaps, unroll thresholds,
   zero/sign limits, masked shifts, carry chains, every shape byte and a full
   sine period, plus deterministic random arithmetic.
5. Restores the full CPU/GPU/SPU/RAM state and checks RAM, scratchpad, and registers.
   It fails closed on unsupported stops, byte mismatches, or restore differences.

Full local cases, fixtures, and build logs go under ignored `ports/evidence/`.
Successful receipts also go under `ports/verification/` with ROM/compiler/runtime,
source and instruction hashes. DLL/build outputs stay under ignored `ports/build/`.
An exit-zero build alone is not acceptance: inspect the receipt's `passed` field
and the exact tested domain. Finite runtime tests do **not** prove all 32-bit
input combinations, timing, rendering/PCM, or complete game behavior.

## Scope still pending

`assembly_inventory.json` distinguishes actual whole-function ASM, inline
instruction/template sites, data/linkage directives, and empty compiler fences.
`recon/syslib` is excluded. `ADDRESS.ASM` supplies overlay boundaries, not a
function needing C reconstruction. Empty compiler fences have no behavioral
implementation. Symbol-name annotations are integration work, not opcodes.

The current site census finds 14 whole assembly blocks and **36 real inline
assembly sites**, separately from 222 empty fences. Macro definitions count as
sites, so 36 is not a count of complete affected functions.

The larger game functions that use inline GTE/EA packet templates are **not yet
fully ported** here. They require an exact portable GTE state/operation backend
(rounding, saturation, flags, FIFOs) and PSX packet-format handling, then tests
of whole function effects. A site census also misses consumers of shared GTE
macros, so it is not advertised as a complete affected-function list.

No matching PASS status was changed to make these host ports compile. The main
SYM/source-restoration goal and its ledger are separate from this porting work.
