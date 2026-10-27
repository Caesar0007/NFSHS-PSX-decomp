/* eaclib/psx/sndpsxz/sbhdrsze.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sbhdrsze.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7B64.  SNDbankheadersize -- the header byte-size of loaded bank `bankId`.  Ghidra.
 */
#include "sbhdrsze.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "sndbankpriv.h"
#include "sndbankhdrpriv.h"

/* SNDbankheadersize @0x800E7B64 : bank @ sndgs[0x26]+bankId*0xc, +0 = data ptr, [data+8] = header size. */
int SNDbankheadersize(int bankId)
{
    struct SndBankDataHeaderPrefix *bank;
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    bank = ((struct SndGlobalServerStateView *)sndgs)->bank_table[bankId].data_block;
    return bank->header_size;
}
