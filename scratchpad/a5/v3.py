exec(open('scratchpad/a5/mkvar.py').read())
COMB_SEQV="""                ((FileOp *)(off + (int)gFileMgr.oparray))->id =
                    (((FileOp *)(off + (int)gFileMgr.oparray))->id & keepType) | seqv;
                if (++gFileOpSeq > (int)seqMask)
                    gFileOpSeq = 0;"""
build("H  literal-mask-head",
      "            unsigned int seqv;\n            seqv = gFileOpSeq & 0xFFFFFu;\n","",COMB_SEQV)
build("L  seqMask-in-head",
      "            unsigned int seqv;\n            seqMask = 0xFFFFFu;\n            seqv = gFileOpSeq & seqMask;\n","",COMB_SEQV)
build("M  head-load-only",
      "            unsigned int seqv;\n            seqv = gFileOpSeq;\n","",
      """                ((FileOp *)(off + (int)gFileMgr.oparray))->id =
                    (((FileOp *)(off + (int)gFileMgr.oparray))->id & keepType) | (seqv & seqMask);
                if (++gFileOpSeq > (int)seqMask)
                    gFileOpSeq = 0;""")
build("N  H+or-operand-swap",
      "            unsigned int seqv;\n            seqv = gFileOpSeq & 0xFFFFFu;\n","",
      """                ((FileOp *)(off + (int)gFileMgr.oparray))->id =
                    seqv | (((FileOp *)(off + (int)gFileMgr.oparray))->id & keepType);
                if (++gFileOpSeq > (int)seqMask)
                    gFileOpSeq = 0;""")
