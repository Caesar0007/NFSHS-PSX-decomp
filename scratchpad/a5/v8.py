import subprocess
P='recon/eaclib/psx/eacpsxz/nfile.c'
BASE=open('scratchpad/a5/nfile_base.c',encoding='utf-8').read()
G0="""            if (((op->id >> 0x14) & 0xF) == 0) {
                op->id = (op->id & clearType) | setType; /* set type nibble = 1 */"""
G1="""            if (((op->id >> 0x14) & 0xF) == 0) {
                unsigned int seq = gFileOpSeq;
                op->id = (op->id & clearType) | setType; /* set type nibble = 1 */"""
C0="""                    (gFileOpSeq & seqMask); /* bits 0-19 = request seq */"""
C1="""                    (seq & seqMask); /* bits 0-19 = request seq */"""
open(P,'w',encoding='utf-8').write(BASE.replace(G0,G1).replace(C0,C1))
