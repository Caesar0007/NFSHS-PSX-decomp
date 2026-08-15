/* syslib/psx/libapi/PAD_data.c -- RETIRED (W66-A3, link lane).
 *
 *   This TU used to carry `int _init_pad_flag;` as the "owning definition" for
 *   PAD.c's extern.  It never worked and it was harmful:
 *
 *     * at 4 bytes the tentative definition routes to a LOCAL .sbss/.bss symbol
 *       (`nm` prints `b`, not `B`), so PAD.c's reference stayed UNDEFINED in the
 *       real link -- the w65-a6 §6.1 falsification, measured again here;
 *     * the private copy sat at whatever address the linker happened to give it,
 *       i.e. at a VA retail does not have -- the same latent class as the
 *       `gRepeatCount` and `sndStreamMap` defects w65-a6 fixed.
 *
 *   The word IS in the retail image at 0x8013C338 and the splat blob already
 *   emits it (asm/data/data_8010CCD4_r21.data.s, `dlabel D_8013C338`, the first
 *   word of a 4-word run whose other words are the 0x1F801040/0x1F801070 pad
 *   MMIO pointers).  PAD.c now aliases its extern onto that label, so the link
 *   resolves against the real storage and nothing is duplicated.
 *
 *   Deliberately empty -- kept as the receipt for a definition that must NOT be
 *   re-added.
 */
