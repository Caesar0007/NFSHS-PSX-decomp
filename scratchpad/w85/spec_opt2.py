L = '          __asm__("" : : "r"(lim), "r"(lim), "r"(lim), "r"(lim));\n'
LBLK = """        int cur = this->fOpenHeight;
        int lim = this->fHeight;
        if (cur < lim) {
          cur = cur + 4;
          if (cur < lim) {
            lim = cur;
          }
          __asm__("" : : "r"(lim), "r"(lim), "r"(lim), "r"(lim));
          this->fOpenHeight = (short)lim;
        }
"""
V = "  *(volatile short *)&this->fEnableVal = sVar2;\n  sv = this->fEnableVal;\n  v = *(u_short *)&this->fEnableVal;\n"

CASES = [
 ("X0 baseline", []),
 ("X1 lim fence out", [(L, "")]),
 ("X2 lim fence out, min form", [(LBLK, """        int cur = this->fOpenHeight;
        int lim = this->fHeight;
        if (cur < lim) {
          cur = cur + 4;
          if (lim <= cur) {
            cur = lim;
          }
          this->fOpenHeight = (short)cur;
        }
""")]),
 ("X3 lim fence out, dial on the store", [(L, ""),
   ("          this->fOpenHeight = (short)lim;\n",
    "          do { this->fOpenHeight = (short)lim; } while (0);\n")]),
 ("X4 lim fence out, extra lim uses in the store expr", [(L, ""),
   ("          this->fOpenHeight = (short)lim;\n",
    "          this->fOpenHeight = (short)(lim | (lim & 0));\n")]),
 ("X5 volatile store out, plain",
  [(V, "  this->fEnableVal = sVar2;\n  sv = this->fEnableVal;\n  v = *(u_short *)&this->fEnableVal;\n")]),
 ("X6 volatile store out, reads from sVar2",
  [(V, "  this->fEnableVal = sVar2;\n  sv = sVar2;\n  v = (u_short)sVar2;\n")]),
 ("X7 volatile store out, dial on the store",
  [(V, "  do { this->fEnableVal = sVar2; } while (0);\n  sv = this->fEnableVal;\n  v = *(u_short *)&this->fEnableVal;\n")]),
 ("X8 volatile moved onto the reads",
  [(V, "  this->fEnableVal = sVar2;\n  sv = *(volatile short *)&this->fEnableVal;\n  v = *(volatile u_short *)&this->fEnableVal;\n")]),
]
