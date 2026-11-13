/* game/common/color.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   color.obj (C:\nfs4\GAME\COMMON\COLOR.CPP) = 2 fns, owns NO data.
 *     IsNumChar         @0x80091ec0 (line 454) -- is char a numeric token (digit / + / -)?
 *     Risk_ReadNextValue@0x80091efc (line 462) -- scan past non-numeric (skip /comment/), atoi next run.
 *   SYM: IsNumChar(c REGPARM); Risk_ReadNextValue(aScript REGPARM, s AUTO char[256], n REG int, Script REG char*).
 *   NOT original source; SYM-faithful, self-contained, recompilable.
 */
#include "color.h"
#include "color_externs.h"

/* Retail color.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }
extern "C" int sprintf(char *buffer, char *fmt, ...);

/* @0x80091ec0  IsNumChar(char c) -- line 454 */
/* Matched NFS2 PC risk/IsNumChar.c confirms this digit/minus/plus return chain.
 * Explicit sign arms retain retail's separate return notes on line458; a direct
 * Boolean tail has identical code but loses those two notes. No extra object
 * or compiler fence is needed. Literal original PSX formatting is unproved. */

#line 453 "C:/nfs4/GAME/COMMON/COLOR.CPP"
char IsNumChar(char c)
{
  if (c >= '0' && c <= '9') return 1;
  else if (c == '-')

    return 1; else if (c == '+') return 1; else return 0;
}

/* @0x80091efc  Risk_ReadNextValue(char **aScript) -- line 462 */

#line 461 "C:/nfs4/GAME/COMMON/COLOR.CPP"
int Risk_ReadNextValue(char **aScript)
{
  char s[256];
  int n; char *Script; n = 0;


  Script = *aScript;

  while (IsNumChar(*Script) == '\0') {


    if ((u_char)*Script++ == '/') {

      while ((u_char)*Script++ != '/') {
      }
    }
  }
  while (IsNumChar(*Script)) { s[n++] = *Script++;
  }
  s[n] = '\0';
  n = atoi(s);
  *aScript = Script;
  return n;
}
