exec(open('scratchpad/a5/mkvar.py').read())
build("A baseline-dial","","", "")
build("G seqv-at-guard-top",
      "            unsigned int seqv;\n",
      "                seqv = gFileOpSeq & seqMask;\n",
      """                ((FileOp *)(off + (int)gFileMgr.oparray))->id =
                    (((FileOp *)(off + (int)gFileMgr.oparray))->id & keepType) | seqv;
                if (++gFileOpSeq > (int)seqMask)
                    gFileOpSeq = 0;""")
build("H seqv-at-loop-top",
      "            unsigned int seqv;\n            seqv = gFileOpSeq & 0xFFFFFu;\n",
      "",
      """                ((FileOp *)(off + (int)gFileMgr.oparray))->id =
                    (((FileOp *)(off + (int)gFileMgr.oparray))->id & keepType) | seqv;
                if (++gFileOpSeq > (int)seqMask)
                    gFileOpSeq = 0;""")
