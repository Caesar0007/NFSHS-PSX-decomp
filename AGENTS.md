# MIPS / Matching-Decomp References (Optional)

**Optional references (do NOT waste context tokens on a full read; consult selectively only when needed):**

1. `C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\reference_mips_isa_asm.md` (MIPS-I/R3000 and GAS authority)
2. `C:\Users\Vyacheslav\.claude\projects\C--Temp-claud\memory\reference_psx_cpp_reconstruction_methodology.md` (matching workflow and verification reference)

This applies to the primary agent and every delegated/sub-agent. Do not require a full upfront read of either file at session start, after context reset, or in sub-agent delegation prompts.

# Forbidden Non-Authentic Compiler Extensions

- **NEVER introduce `__complex__`, `__real__`, `__imag__`, `__inline__`, `__asm__`, or `asm(...)` labels/barriers** in reconstructed source/headers (outside `recon/syslib`).
- Existing occurrences of `__complex__`, `__real__`, `__imag__`, `__inline__`, and `__asm__` / `asm` must be actively eliminated and replaced with authentic C/C++ constructs while strictly preserving 100% function byte match (`BYTES: UNCHANGED`) and SYM/SLD parity.

