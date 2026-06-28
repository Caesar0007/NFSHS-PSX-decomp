/* game/common/color.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   color.obj (C:\nfs4\GAME\COMMON\COLOR.CPP) = 2 fns, owns NO data.
 *     IsNumChar         @0x80091ec0 (line 454) -- is char a numeric token (digit / + / -)?
 *     Risk_ReadNextValue@0x80091efc (line 462) -- scan past non-numeric (skip /comment/), atoi next run.
 *   SYM: IsNumChar(c REGPARM); Risk_ReadNextValue(aScript REGPARM, s AUTO char[256], n REG int, Script REG char*).
 *   NOT original source; SYM-faithful, self-contained, recompilable.
 */
#include "color.h"
#include "color_externs.h"

/* @0x80091ec0  IsNumChar(char c) -- line 454 */
char IsNumChar(char c)
{
  if ((u_char)(c - 0x30U) < 10) {
    return '\x01';
  }
  if ((u_char)c == '-') {
    return '\x01';
  }
  return (u_char)c == '+';
}

/* @0x80091efc  Risk_ReadNextValue(char **aScript) -- line 462 */
int Risk_ReadNextValue(char **aScript)
{
  char s[256];
  char *Script;
  char *pcVar2;
  char cVar1;
  int n;

  n = 0;
  Script = *aScript;
  while (IsNumChar(*Script) == '\0') {     /* skip to the next number; oracle loop @0x80091f24 */
    if (*Script != '/') {                    /* non-numeric, non-'/' -> advance + loop (oracle F48 bne+delay) */
      Script = Script + 1;
      continue;
    }
    Script = Script + 1;                     /* past the opening '/' (@0x80091f4c delay) */
    if (*Script == '/') {                    /* empty "//" -> skip 2nd '/' + loop (@0x80091f58 beq+delay) */
      Script = Script + 1;
      continue;
    }
    Script = Script + 1;                     /* into the comment body (@0x80091f5c delay) */
    while (*Script != '/')                   /* scan to the closing '/' (@0x80091f64) */
      Script = Script + 1;
    Script = Script + 1;                     /* past the closing '/' (@0x80091f70 delay); j top (@0x80091f74) */
  }
  while (true) {
    cVar1 = IsNumChar(*Script);
    pcVar2 = s + n;
    if (cVar1 == '\0') break;
    cVar1 = *Script;
    Script = Script + 1;
    n = n + 1;
    *pcVar2 = cVar1;
  }
  s[n] = '\0';
  n = atoi(s);
  *aScript = Script;
  return n;
}
