/* eaclib/psx/sndpsxz/sballoc.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sballoc.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x801027BC.  iSNDbankalloc -- find the first free bank-table slot.  Ghidra (void) + IDA (int).
 */

extern "C" int sndgs[];

extern "C" int iSNDbankalloc(void);   /* @0x801027BC */

/* iSNDbankalloc @0x801027BC : return the index of the first empty bank table entry (sndgs[0x26], 0xc
 *   stride, +0 == 0 means free), or -9 (SND_BANKFULL) if the table is empty/full.  (Ghidra lost the
 *   return value; IDA gives int.) */
extern "C" int iSNDbankalloc(void)
{
    int  i = 0;
    int  n = (int)(unsigned)(unsigned short)sndgs[3];   /* cache the bank count in a reg (oracle a1), reuse it */
    int *e = (int *)sndgs[0x26];
    if (n != 0) {
        do {
            if (*e == 0)
                return i;
            i++;
            e = e + 3;
        } while (i < n);
    }
    return -9;   /* H06: SND_BANKFULL on count==0 and no-empty-slot fall-through (oracle 0x80102804 $v0=-9); was `return i` */
}
