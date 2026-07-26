exec(open('scratchpad/a5/mkvar.py').read())
COMB_SEQV="""                ((FileOp *)(off + (int)gFileMgr.oparray))->id =
                    (((FileOp *)(off + (int)gFileMgr.oparray))->id & keepType) | seqv;
                if (++gFileOpSeq > (int)seqMask)
                    gFileOpSeq = 0;"""
build("L  seqMask-in-head",
      "            unsigned int seqv;\n            seqMask = 0xFFFFFu;\n            seqv = gFileOpSeq & seqMask;\n","",COMB_SEQV, write_only=True)
