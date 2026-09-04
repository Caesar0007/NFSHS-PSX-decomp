/* eaclib/psx/spchpsxz/spchdata.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 6/6 ***
 *   Source obj : nfs4\eaclib\psx\spchdata.obj ; archive C:\nfs4\EACLIB\PSX\SPCHPSXZ.LIB (xlsx col12 / SYM v3)
 *   6 fns @[0x80100710 .. 0x80100760].  Leaf accessors into the speech Vox* data structures (a sentence's
 *   short-rule/phrase-count fields, an event's filter-length flag, and the +4-byte offset-table helpers).
 *   Ghidra nfs4-f.exe.c (spchdata) EMPTIED these (delay-slot `goto $ra` returns dropped); real bodies from
 *   disasm-v3 + IDA sigs.
 *
 *   Linkage note: VoxSentence_GetNumPhrases / VoxEvent_GetFilterLengthFlag / iSPCH_GetOffset8 / GetOffset16
 *   also appear at their OWN VAs inside spchevnt.obj and spchrule.obj (per-TU `static` inline copies of the
 *   same shared-header helpers). spchdata holds the canonical exported versions here; the duplicate
 *   copies in spchevnt/spchrule are `static`. VA-suffixed co-equal labels below exist only because the
 *   oracle/config namespace cannot represent several retail local symbols with one spelling.
 */

#include "../eaclib_types.h"
#include "spch_types.h"
#include "spchdata.h"

/* iSPCH_GetMatchValue @0x80100710 : matchValues[index] -- the int table right after the header. */
int iSPCH_GetMatchValue(VoxPhrase *phrase, int index)
{
    int *values = (int *)(phrase + 1);   /* +0x8 */
    return values[index];
}

/* VoxSentence_GetShortRule @0x80100724 : low 2 bits of the sentence's flags byte (+3). */
int VoxSentence_GetShortRule(VoxSentence *sentence)
{
    return sentence->flags & 3;
}

/* VoxSentence_GetNumPhrases @0x80100730 : upper 6 bits of the sentence's flags byte (+3). */
int VoxSentence_GetNumPhrases(VoxSentence *sentence)
{
    return sentence->flags >> 2;
}

/* VoxEvent_GetFilterLengthFlag @0x8010073C : bit 0 of the event's flags byte (+0xa). */
int VoxEvent_GetFilterLengthFlag(VoxEvent *event)
{
    return event->flags & 1;
}

/* iSPCH_GetOffset8 @0x80100748 : follow an 8-bit offset table -- base + (table[index] << 2). */
int iSPCH_GetOffset8(int base, int tableBase, int index)
{
    return base + ((int)*(unsigned char *)(tableBase + index) << 2);
}

/* iSPCH_GetOffset16 @0x80100760 : follow a 16-bit offset table -- base + (table[index] << 2). */
int iSPCH_GetOffset16(int base, int tableBase, int index)
{
    return base + ((int)*(unsigned short *)(tableBase + index * 2) << 2);
}
