/* textpsx_externs.h -- externs referenced by textpsx.cpp (GAME/PSX/TEXTPSX.C text-draw hooks) */
#ifndef TEXTPSX_EXTERNS_H
#define TEXTPSX_EXTERNS_H

/* currentfont: active-font working-state blob @ 0x80135ba0 (spans 696B to Font@0x80135e58).
 * Defined in a sibling font TU; this TU only touches the word field at +0x94 and the
 * text-draw fn-ptr field at +0x148, both by raw offset (no named struct in this TU's SYM). */
extern unsigned char currentfont[];

#endif /* TEXTPSX_EXTERNS_H */
