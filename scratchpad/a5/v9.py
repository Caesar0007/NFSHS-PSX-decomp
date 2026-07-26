import subprocess
P='recon/eaclib/psx/eacpsxz/nfile.c'
U=open('scratchpad/a5/nfile_varU.c',encoding='utf-8').read()
s=U.replace("        unsigned int seqMask = 0xFFFFFu;\n","        unsigned int seqMask;\n")
s=s.replace("""            FileOp *op = (FileOp *)(off + (int)gFileMgr.oparray);""","""            FileOp *op = (FileOp *)(off + (int)gFileMgr.oparray);
            seqMask = 0xFFFFFu;""",1)
open(P,'w',encoding='utf-8').write(s)
