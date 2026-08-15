import json, os
NL = "\n"
OLD = ('    if ((((mode == 1) || (mode == 4)) || (this->perpTarget_ == (AIHigh_Player *)0x0)) ||' + NL + NL
       + '            (1 < (((this->perpTarget_)->carObj_)->stats).finishType)) {' + NL + NL
       + '      if ((mode == 1) || (mode == 4)) {' + NL)
HEAD = ('    if ((((mode == 1) || (mode == 4)) || (this->perpTarget_ == (AIHigh_Player *)0x0)) ||' + NL + NL
        + '            (1 < (((this->perpTarget_)->carObj_)->stats).finishType)) {' + NL + NL)

V = [
    {"name": "c1_named4_inner",
     "subs": [[OLD, HEAD + '      int m4 = 4;' + NL + NL
               + '      if ((mode == 1) || (mode == m4)) {' + NL]]},
    {"name": "c2_named4_fenced",
     "subs": [[OLD, HEAD + '      int m4;' + NL + '      m4 = 4;' + NL
               + '      __asm__("" : "=r"(m4) : "0"(m4));' + NL + NL
               + '      if ((mode == 1) || (mode == m4)) {' + NL]]},
    {"name": "c3_reread_mode_inner",
     "subs": [[OLD, HEAD + '      blockadeMode_t mode1b = this->blockade_.mode;' + NL + NL
               + '      if ((mode1b == 1) || (mode1b == 4)) {' + NL]]},
    {"name": "c4_named4_both",
     "subs": [[OLD,
               '    { int m4 = 4;' + NL
               + '    if ((((mode == 1) || (mode == m4)) || (this->perpTarget_ == (AIHigh_Player *)0x0)) ||' + NL + NL
               + '            (1 < (((this->perpTarget_)->carObj_)->stats).finishType)) {' + NL + NL
               + '      m4 = 4;' + NL
               + '      if ((mode == 1) || (mode == m4)) {' + NL]]},
]
p = os.path.join(os.path.dirname(__file__), "cop_v1.json")
json.dump(V, open(p, "w", encoding="utf-8"))
print(p)
