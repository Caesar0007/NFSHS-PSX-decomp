# P881: lasttick restored as a real source-owned local static

`tCreditManager::SetupCurrCredit` now declares `static int lasttick = 0` in
its function scope. The invented FECredits_lastFadeTick/A_ extern view and
public declaration are removed. No new asm, volatile, helper name or emitted
instruction rewrite was introduced.

## Native and compiler proof

Native SYM5f1f9a is STAT INT lasttick at object-relative data offset4.
CREDFADETICKS is at80051AA0; the static is at80051AA4. The exact eight-byte
initialized run is `bc020000 00000000` (700,0). ScreenMain's tvOrder begins
at80051AA8 and is a different owner; it was not absorbed into credits.

The ordinary zero-initialized local static emits exactly that eight-byte
.data section, with global CREDFADETICKS at+0 and local lasttick.18 at+4.
Its live debug record is `.scl 3; .type 0x4`, inside SetupCurrCredit.
An otherwise byte-PASS tentative static instead produces four bytes in .bss:
it is rejected as the wrong source/data layout. This demonstrates why a
normalized function PASS alone cannot certify static storage restoration.

All seven functions remain PASS, branch-clean and target exact-g199/199.
The 3,240 text bytes differ from the old object only in two unlinked LO16
addend bytes (0->4), because the references now target the owning .data+4
instead of the fake external D_80051AA4. Other instruction bytes and rodata
remain unchanged. verify_source.py/source_receipts.json prove these claims.

Native SYM/MAP and merged raw nfs4-f.exe establish initialized frontend data.
The CPE contains only the zero frontend reservation here, not these live
initialized bytes; it is not misrepresented as their content oracle.

## One actual backing cell per lane

The old raw r03 window was split without changing its data or labels:

- Prefix:800517BC..80051AA0,740 bytes, retained in front_data_r03.data.s.
- Oracle-only owner:80051AA0..80051AA8,8 bytes, front_data_fecredits_legacy.data.s.
- Suffix:80051AA8..80052058,1,456 bytes, front_data_r03_after_fecredits.data.s.

The src linker selects all three raw pieces in order. Recon selects the
source credits .data instead of the raw eight-byte owner. Independent ordinary
links prove both complete 2,204-byte data windows equal raw retail exactly.
Recon contains one local lasttick at80051AA4 and no raw D_80051AA4 definition.
The old raw cell remains available only to the oracle/source lane.

tools/source_data_owners.py records this native data ownership and validates
the exact payload, section size and real global/local offsets before allowing
the raw copy to be excluded. A stale four-byte owner object fails closed.
Normal PsyQ ELF data symbols have size0/NOTYPE; offsets/payload bound the cells,
while source/-g checks establish INT. Zero symbol size is not mistaken for
zero allocated storage.

Both tools/relink.py and tools/gen_ld.py exclude the oracle-only object from
recon inputs. The active generator explicitly places the source data at its
native address and keeps it out of the generic resident data tail. Updating
the dormant frontend fragment alone would not have accomplished this.
The fragment is updated too so its documented source ordering stays valid.

The canonical generator now uses live C/C++ and raw source paths when choosing
inputs; stale cached probe objects cannot silently reintroduce another cell.
Its link command also consumes the existing retail_data_symbols.ld PROVIDE
metadata, resolving the previously omitted overlay-end/BSS boundary names
without allocating storage. Generated nfs4_recon.ld is regenerated from these
current inputs, not hand-patched.

verify_storage.py/storage_receipts.json prove the two raw windows, stale-owner
rejection, actual generator response-file exclusion, exact canonical owner
address and all four linked lasttick-reference words against the raw EXE.
The first window-link attempt used mixed relative/absolute paths and GNU ld
opened inputs twice; the harness now uses identical relative spelling rather
than suppressing the duplicate-definition error.

## Verification limits and handoff

The standing link gate is green with zero REAL duplicates, phantoms and
relocation-referenced unresolveds. Known raw/source blob duplicates decrease
964->963. The broader generated diagnostic link has zero unresolved names
after recovered metadata is included, but printed ten small-data relocation
diagnostics (later exhaustively counted as 324 actual failures in P882) and
retained unrelated layout debt. See ../p882_gprel/BASELINE_RECEIPT_20260906.md.
--noinhibit-exec can report rc0 despite
those diagnostics: this is not a clean final-executable or whole-project claim.

full_validation.py/full_validation_receipts.json record the complete three-build
regression sequence and final checks. Only a fully completed sequence is a
verification result; an in-progress log is not a PASS. Protected tool/source/
linker backups are in backups/. New files and data splits are recoverable
there or from Git; no original raw payload was discarded.

The strict frontend report again has zero missing names and781 declaration-clean
functions, now with a real lasttick declaration and no carrier exemption.
Other SetupCurrCredit carriers, original inline spellings and complete SLD
restoration remain open. No commit/push is made by this round.
