exec(open('scratchpad/a5/s1.py').read().split('t("shipped"')[0])
MERGED="""    cur  = MI(s, 0x50);
    done = 1;
    if (cur != 0) {
        done = MI(cur, 4);                      /* merged: state temp IS done */
        if (done != 1) {                        /* current no longer queued */
            int nx = MI(cur, 0xc);              /* advance to next */
            if (nx == 0)
                done = 1;
            else {
                MI(s, 0x50) = nx;
                done = 0;
            }
        } else {
            done = 0;
        }
    }"""
t("merged", MERGED, keep=True)
