/* eaclib/psx/spchpsxz/spchdata.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 6/6 ***
 *   Source obj : nfs4\eaclib\psx\spchdata.obj ; archive C:\nfs4\EACLIB\PSX\SPCHPSXZ.LIB (xlsx col12 / SYM v3)
 *   6 fns @[0x80100710 .. 0x80100760].  Leaf accessors into the speech Vox* data structures (a sentence's
 *   short-rule/phrase-count fields, an event's filter-length flag, and the +4-byte offset-table helpers).
 *   Ghidra nfs4-f.exe.c (spchdata) EMPTIED these (delay-slot `goto $ra` returns dropped); real bodies from
 *   disasm-v3 + IDA sigs.
 *
 *   Linkage note: VoxSentence_GetNumPhrases / VoxEvent_GetFilterLengthFlag / iSPCH_GetOffset8 / GetOffset16
 *   also appear at their OWN VAs inside spchevnt.obj and spchrule.obj (per-TU `static` inline copies of the
 *   same shared-header helpers).  spchdata holds the canonical exported (extern "C") versions here; the
 *   duplicate copies in spchevnt/spchrule are reconstructed as `static` to avoid multiple-definition.
 */

extern int iSPCH_GetMatchValue(int base, int index);                  /* @0x80100710 */
extern int VoxSentence_GetShortRule(int sentence);                    /* @0x80100724 */
extern int VoxSentence_GetNumPhrases(int sentence);                   /* @0x80100730 */
extern int VoxEvent_GetFilterLengthFlag(int event);                   /* @0x8010073C */
extern int iSPCH_GetOffset8(int base, int tableBase, int index);      /* @0x80100748 */
extern int iSPCH_GetOffset16(int base, int tableBase, int index);     /* @0x80100760 */

/* iSPCH_GetMatchValue @0x80100710 : read the int at entry `index` of the table that starts at base+8.
 * MATCH: in-place dead-ptr mutate: base += index*4 forces oracle's addu a0,a0,a1; lw v0,8(a0) */
extern int iSPCH_GetMatchValue(int base, int index)
{
    base += index * 4;
    return *(int *)(base + 8);
}

/* VoxSentence_GetShortRule @0x80100724 : low 2 bits of the sentence's flags byte (+3). */
extern int VoxSentence_GetShortRule(int sentence)
{
    return (int)*(unsigned char *)(sentence + 3) & 3;
}

/* VoxSentence_GetNumPhrases @0x80100730 : upper 6 bits of the sentence's flags byte (+3). */
extern int VoxSentence_GetNumPhrases(int sentence)
{
    return (int)((unsigned int)*(unsigned char *)(sentence + 3) >> 2);
}

/* VoxEvent_GetFilterLengthFlag @0x8010073C : bit 0 of the event's flags byte (+0xa). */
extern int VoxEvent_GetFilterLengthFlag(int event)
{
    return (int)*(unsigned char *)(event + 0xa) & 1;
}

/* iSPCH_GetOffset8 @0x80100748 : follow an 8-bit offset table -- base + (table[index] << 2). */
extern int iSPCH_GetOffset8(int base, int tableBase, int index)
{
    return base + ((int)*(unsigned char *)(tableBase + index) << 2);
}

/* iSPCH_GetOffset16 @0x80100760 : follow a 16-bit offset table -- base + (table[index] << 2). */
extern int iSPCH_GetOffset16(int base, int tableBase, int index)
{
    return base + ((int)*(unsigned short *)(tableBase + index * 2) << 2);
}
