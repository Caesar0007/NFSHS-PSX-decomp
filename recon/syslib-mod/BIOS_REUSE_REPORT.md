# PSX BIOS reuse audit for syslib-mod

Authority: SCPH-5502 BIOS used by the paired runtime and the local PSX-SPX `kernelbios.md` function
catalog. BIOS calls use A0/B0/C0 vectors with the function number in `$t1`.

## Already optimized in retail NFS4

Most libc string/memory primitives and libapi kernel/card calls are already 12-byte BIOS thunks:

- strings: `strcmp`, `strncmp`, `strcpy`, `strncpy`, `strlen`, `strchr`, `strrchr`, `strcat`;
- memory: `memcpy`, `memset`, `memchr`, `bzero`;
- misc libc: `atoi`, `toupper`, `tolower`, `rand`, `printf`, `puts`, `setjmp`;
- events/threads/interrupt hooks: `DeliverEvent`, `OpenEvent`, `CloseEvent`, `TestEvent`,
  `EnableEvent`, `DisableEvent`, `HookEntryInt`, `ResetEntryInt`, `SysEnqIntRP`, `SysDeqIntRP`;
- BIOS file/card operations and cache/heap wrappers.

Replacing these wrappers cannot yield material savings: the resident wrapper is already three
instructions. `memmove` and `memcmp` intentionally remain software implementations because the BIOS
versions are documented as bugged. `sprintf` and floating-point helpers have no BIOS equivalent.

## Empirically rejected substitutions

### BIOS qsort and bsearch

Theoretical saving: 564 bytes (`qsort` object 396 -> 12, `bsearch` 192 -> 12).

- Combined A0:31/A0:36 candidate timed out before startup.
- Isolated A0:31 `qsort` reached startup at pad frame 5,253 versus retail 6,926 and produced broad
  game-state divergence.
- Isolated A0:36 `bsearch` timed out before candidate frame 1,000.

They are not ABI/behavior-compatible replacements for the PsyQ objects used by EAC CDFS and game
sorting. Keep the software implementations.

Receipts:

- `C:\Temp\nfs4-syslib-pair\reports\bios-sort-startup-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\bios-qsort-startup-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\bios-bsearch-startup-20261002-01\report.json`

### BIOS GPU low-level helpers

Candidate replacements were `_send_gp0 -> A0:4A`, `_gpu_dma_chain -> A0:4B`, and
`_get_status -> A0:4D` (theoretical combined saving 124 bytes). The candidate stalls before startup.

This is expected from the BIOS contract:

- A0:4A calls BIOS `gpu_sync()` before sending words; NFS4 `_send_gp0` explicitly disables DMA and
  writes immediately.
- A0:4B calls `gpu_sync()`, modifies DPCR, starts DMA, and emits TTY diagnostics; NFS4's helper is
  coordinated with PsyQ's own queue and DMA callback.
- NFS4 `_send_gp1` additionally maintains a 256-byte GP1 software shadow, which BIOS A0:48 does not.

Direct GPU thunk substitution is rejected. Any reuse must be behind a new queue-aware adapter and
is unlikely to repay its risk for roughly one hundred bytes.

Receipt: `C:\Temp\nfs4-syslib-pair\reports\bios-gpu-startup-20261002-01\report.json`.

## BIOS services that are not suitable replacements

- **Pad B0:12..16:** BIOS polling supports only digital ID 0x41 and limited ID 0x23 behavior. It
  does not preserve NFS4's analog modes, NegCon handling, actuator alignment, or force feedback.
- **Memory allocation A0:33..39:** NFS4 uses EAC's allocator and named arenas. BIOS heap semantics,
  ownership and failure behavior are not interchangeable.
- **Interrupt C0 services:** `SysDeqIntRP` is documented as bugged. PsyQ's callback layer and private
  interrupt stack cannot be removed by redirecting one wrapper.
- **GPU upload A0:46/47:** documented odd-size/multiple-of-32 transfer bugs and very slow uncached
  software copies make them unsuitable for general NFS4 texture traffic.
- **GTE, MDEC and floating point:** no BIOS replacements exist for the resident routines/tables.
- **SN `PC*` breaks:** these are devkit expansion-ROM services, not standard retail BIOS services.
  The verified syslib-mod error stubs remain the correct retail-console reduction.

## Potential BIOS-backed CD adapter (future experiment)

The retail BIOS offers synchronous `CdReadSector` and asynchronous `CdAsyncSeekL`,
`CdAsyncReadSector`, `CdAsyncGetStatus`, and `CdAsyncSetMode`. A syslib-mod adapter could in theory
replace part of the 5.5 KiB low-level CD driver while preserving the unchanged EAC API.

It is not a direct thunk replacement:

- BIOS normal file reads are synchronous;
- `CdGetLbn` has documented not-found/first-entry bugs;
- BIOS has no CD-audio support and no XA filter API;
- completion is exposed through BIOS events rather than PsyQ's ready/sync/data callback slots;
- door-open handling does not reload the path table automatically;
- NFS4 movie `ReadS`, EAC music/speech streaming, callback order, retry and timeout behavior must be
  reconstructed by the adapter.

Treat this as a later isolated branch. Required gates are sector/data CRC, callback-order traces,
music/speech/SPU state, STR playback, lid-open recovery, cleanup, and long untaped soak. The current
7,566-byte syslib-mod CD core is the safe baseline.

The narrower use of BIOS A0:A5 solely to reload the overlay artifact was also runtime-tested. A
single sector request issued after the PsyQ stack had initialized did not complete at the paired
`Track_Init` gate. This confirms that even bootstrap reads cannot take BIOS CD interrupt ownership
while NFS4's PsyQ/EAC stack is active. The accepted overlay design performs its only disc load
before the race through the unchanged asynchronous EAC scheduler and restores from a resident
RefPack stream; it does not retain or invoke a competing BIOS/PsyQ sector reader during cleanup.
