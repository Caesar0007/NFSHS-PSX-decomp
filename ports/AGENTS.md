# Portable ASM counterparts

This tree is a behavioral-port layer, not the PSX matching lane. Follow the
repository's mandatory ISA/reference reads, then `ports/README.md`.

- Write ordinary C11, with fixed-width arithmetic and explicit PSX endian
  access. No ASM, register pins, opcode byte bodies, matching fences, or fake
  hardware stubs in the portable implementations.
- Preserve `recon/`, `src/`, SDK, and production build tooling. Host integration
  belongs here unless the user separately authorizes changes elsewhere.
- Trace raw ROM/SYM behavior before trusting an existing `#else` host fallback.
  Preserve quirks, wraparound, argument order, mutable state, and fault outcomes.
  Hardware-dependent work needs a real portable model, not a successful no-op.
- Clearly separate valid API domains from malformed pointers/MMIO/overflow
  cases. Represent exceptions explicitly when there is no host equivalent.
- For runtime evidence use the already-adapted PSX-Dynamic-Decomp client and
  NFS4's own patched DuckStation on port2350. Verify actual listener/PID/path;
  never attach to another project or interrupt the user's manual game.
- The routine audit uses synthetic isolated calls, not a whole-game scenario.
  Verify oracle bytes against ROM, save/restore full state, compare all declared
  effects, reject unexpected writes, and hash source/runtime/input artifacts.
  Finite test PASS must never be advertised as universal equivalence.
- `assembly_inventory.json` is a site census. Empty compiler fences, data-only
  directives, aliases, and shared GTE macro consumers are different categories.
  Do not equate an ASM-site count with complete-function coverage.
- Build/evidence directories and generated inventory/JSON receipts are ignored.
  Keep successful receipts locally in `verification/`; do not publish generated
  files, BIOS/runtime executables, or ROM contents (user checkpoint policy).
