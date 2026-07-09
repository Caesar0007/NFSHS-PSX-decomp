/* syslib/psx/libapi/COUNTER_data.c -- owning defs for the COUNTER.OBJ RCnt base globals.
 *   Kept in a separate TU from COUNTER.cpp so the code TU sees them as extern and emits
 *   absolute lui/%hi addressing (matching the oracle); a def in COUNTER.cpp would make these
 *   ≤4-byte initialized globals land in -G4 small-data -> gp-relative (§3.12 #6).
 *   Values are byte-exact from the EXE image (data_8010CCD4.data.s @0x801234B4..0x801234BC). */

extern unsigned char  *RCnt_regs = (unsigned char *)0x1F801100;          /* @0x801234B8 */
extern unsigned char  *RCnt_ctrl = (unsigned char *)0x1F801070;          /* @0x801234B4 */
extern unsigned long   RCnt_irq[6] = { 0x10, 0x20, 0x40, 0x1, 0, 0 };    /* @0x801234BC */
