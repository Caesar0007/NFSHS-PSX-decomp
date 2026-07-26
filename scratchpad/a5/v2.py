exec(open('scratchpad/a5/mkvar.py').read())
build("G seqv-at-guard-top",
      "            unsigned int seqv;\n",
      "                seqv = gFileOpSeq & seqMask;\n",
      """                ((FileOp *)(off + (int)gFileMgr.oparray))->id =
                    (((FileOp *)(off + (int)gFileMgr.oparray))->id & keepType) | seqv;
                if (++gFileOpSeq > (int)seqMask)
                    gFileOpSeq = 0;""", write_only=True)
