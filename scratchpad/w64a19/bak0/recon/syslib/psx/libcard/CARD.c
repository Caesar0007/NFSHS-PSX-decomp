/* syslib/psx/libcard/CARD.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libcard.lib(CARD.OBJ): _card_clear -- the one piece of real (non-thunk) code in the cluster.
 *   It "clears" the directory frame of the card on channel `chan`: first arm the BIOS to accept a
 *   (possibly new) card via _new_card, then write the directory-broken-block sector 0x3F with a
 *   NULL source buffer (which the BIOS treats as a wipe).  The result of the write is returned. */

extern void _new_card(void);                             /* A80.OBJ : BIOS B0:0x50 */
extern int  _card_write(int chan, int block, unsigned char *buf);  /* A78.OBJ : BIOS B0:0x4E */

/* @0x80109D20 : _card_clear */
extern int _card_clear(int chan)
{
    _new_card();
    return _card_write(chan, 0x3f, 0);
}
