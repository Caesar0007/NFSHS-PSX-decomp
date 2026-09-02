FENCE = ('      /* Pin-free zero-insn fence: retain the retail byte-extension boundary. */\n'
         '      __asm__("" : "+r"(selectedChar));\n')
CHAR = "      character = (u_int)selectedChar & 0xff;\n"
CMP = "    if ((u_int)(selectedChar - 0x23) < 2) {\n"
DECL = "  u_char selectedChar;\n"

CASES = [
 ("W0 baseline", []),
 ("W1 fence out", [(FENCE, "")]),
 ("W2 fence out, plain & 0xff", [(FENCE, ""), (CHAR, "      character = selectedChar & 0xff;\n")]),
 ("W3 fence out, character = (u_char) cast", [(FENCE, ""), (CHAR, "      character = (u_int)(u_char)selectedChar;\n")]),
 ("W4 fence out, compare via an int copy",
  [(FENCE, ""), (CMP, "    if ((u_int)((int)selectedChar - 0x23) < 2) {\n")]),
 ("W5 fence out, selectedChar as u_int",
  [(FENCE, ""), (DECL, "  u_int selectedChar;\n")]),
 ("W6 fence out, selectedChar u_int + plain mask",
  [(FENCE, ""), (DECL, "  u_int selectedChar;\n"), (CHAR, "      character = selectedChar & 0xff;\n")]),
 ("W7 fence out, character via a fresh read",
  [(FENCE, ""),
   (CHAR, "      character = (u_int)(u_char)this->fRowList[this->fCurrentRow][this->fCurrentColumn] & 0xff;\n")]),
 ("W8 fence out, dial on the character stmt",
  [(FENCE, ""), (CHAR, "      do { character = (u_int)selectedChar & 0xff; } while (0);\n")]),
]
