/* eaclib/psx/eacpsxz/wildcard.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\wildcard.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   2 fns: strrstr@0x800E8940, wildcard@0x800E89BC.  FULL reconstruction (disasm-v3 MIPS); no stubs.
 *   Used by AudioMus/AudioEng to filter song-name lists with a boolean+glob pattern language.
 *
 *   strrstr(s, set) : return a pointer to the RIGHTMOST char of `s` that is any char in `set`
 *                     (0 if none).  Implemented over libc strrchr, keeping the max pointer.
 *
 *   wildcard(text, pat) : 1 if `pat` matches `text`, else 0.  `pat` is a boolean expression over
 *   glob sub-patterns; it is split at the RIGHTMOST operator from the set "&|!~^" (so operators are
 *   same-precedence, right binds loosest), recursing on the two halves (the operator char is
 *   temporarily NUL'd in-place then restored):
 *       '&' a&b  -> a AND b        '|','!','~'  a|b -> a OR b   (all three share the OR code)
 *       '^' a^b  -> a XOR b
 *   With no operator, a leaf glob match is anchored at the start of `text`:
 *       '*' -> match zero-or-more chars (try the rest of pat at each text position)
 *       '?' -> match any one non-NUL char        '#' -> match any one digit (libc ctype &4)
 *       '~' -> NOT (negate the match of the rest of pat)
 *       else -> case-insensitive literal (libc tolower); success as soon as pat is exhausted.
 */
extern char *strrchr(const char *s, int c);   /* libc C31.obj, BIOS A0:0x1F */
extern int   tolower(int c);                   /* libc C38.obj, BIOS A0:0x26 */

extern char *strrstr (char *s, char *set);    /* @0x800E8940 */
extern int   wildcard(char *text, char *pat); /* @0x800E89BC */

/* strrstr @0x800E8940 : rightmost position in `s` of any char of `set` (0 if none).
 * Oracle: initial beqz-if-empty guard (s1=0 in delay slot) falls through into the do-while body;
 * a `do{}while(cond); return X;` where the guard is an early `return X;` (same shape) makes gcc
 * ROTATE the guard into an unconditional `j` to the loop's bottom test instead of the oracle's real
 * `beqz`-to-exit + fall-through-into-body. Nesting the do-while inside `if (cond) { ... }` (no early
 * return) suppresses the rotation and matches byte-for-byte -- branch-polarity/early-return lever
 * (§3.12 #7 pairing) applied to a loop guard, not just a boolean select. */
extern char *strrstr(char *s, char *set)
{
    char *best = 0;
    if (*set != 0) {
        do {
            char *p = strrchr(s, *set);     /* libc strrchr, BIOS A0:0x1F */
            if (best < p)                    /* keep the rightmost (max) hit */
                best = p;
            set++;
        } while (*set);
    }
    return best;
}

/* wildcard @0x800E89BC : boolean+glob pattern match, 1 == match.
 * FAITHFUL QUIRK: the operator restore is a LITERAL per case -- '|' stores back '|', but '!' AND '~'
 * both store back '!' (a '~' OR-operator is rewritten to '!' in the caller's pattern buffer); only
 * the '&' and '^' cases restore the saved char.  The '#' digit test uses the libc _ctype_ table. */
extern const unsigned char _ctype_[];      /* libc CTYPE0.obj @0x801371D0; isdigit bit = 4 */

extern int wildcard(char *text, char *pat)
{
    static const char kOps[] = "&|!~^";   /* @0x8013DC48 (wildcard.obj-local rodata) */
    char *op = strrstr(pat, (char *)kOps);
    const unsigned char *ct;               /* s3 (reuses op's reg): _ctype_ + 1 in the leaf */
    int r;                                 /* s0 */

    if (op) {                              /* split at the rightmost operator */
        int ch = *op;                      /* s4, lbu (int local: no u_char re-mask, oracle bne s4) */
        if (ch == '&') {                   /* AND */
            *op = 0;
            r = 0;
            if (wildcard(text, pat))
                r = wildcard(text, op + 1) != 0;
            *op = ch;
            return r;
        }
        if (ch == '|') {                   /* OR */
            *op = 0;
            r = 0;
            if (wildcard(text, pat) || wildcard(text, op + 1))
                r = 1;
            *op = '|';                     /* literal restore */
            return r;
        }
        if (ch == '!' || ch == '~') {      /* OR (both spellings) */
            *op = 0;
            r = 0;
            if (wildcard(text, pat) || wildcard(text, op + 1))
                r = 1;
            *op = '!';                     /* literal restore -- '~' comes back as '!' */
            return r;
        }
        if (ch == '^') {                   /* XOR */
            *op = 0;
            r = wildcard(text, pat) ^ wildcard(text, op + 1);
            *op = ch;
            return r;
        }
        /* ch not an operator (unreachable: strrstr only returns kOps hits) -> falls to the leaf */
    }
    goto leaf;
notleaf:                                   /* '~' leaf body -- emitted BEFORE the loop (oracle .LB04) */
    return (unsigned int)wildcard(text, pat + 1) < 1;
leaf:
    /* no operator -> leaf glob match, anchored at the start of `text` */
    ct = _ctype_ + 1;
    for (;;) {
        int pc = *pat;                     /* v1 (int local: also tips the allocno
                                            * priority so text gets $s1, pat $s2) */
        int v;
        if (pc == '*') {                   /* glob: try the rest at each text position */
            pat++;
            do {
                if (wildcard(text, pat))
                    return 1;
            } while (*text++ != 0);
            return 0;
        }
        if (pc == '?') {                   /* any one non-NUL char */
            v = *text;
            pat++;
            goto join;
        }
        if (pc == '#') {                   /* any one digit (ctype bit 4) */
            v = *(const unsigned char *)((int)*text + (int)ct) & 4;  /* index+base addu order */
            pat++;
join:                                      /* MATCH: shared tail -- text++ lands in the beqz delay
                                            * slot (oracle .LB90), '?' jumps in, '#' falls through */
            text++;
            if (v == 0)
                goto ret0;
            continue;
        }
        if (pc == '~')                     /* NOT the rest */
            goto notleaf;
        {                                  /* case-insensitive literal compare */
            int t = tolower(*pat);         /* s0; tolower'd FIRST.  RESIDUAL (14 diffs): with the
                                            * int `pc` this *pat re-read CSEs into a copy from pc,
                                            * which gives pc an $a0 preference (oracle: fresh lbu,
                                            * pc in $v1).  Blocking the CSE (u_char pc / volatile)
                                            * restores the lbu but adds +2 weighted pat refs ->
                                            * text/pat allocno order flips back (s1<->s2 swap, 70
                                            * diffs).  The two fixes are ref-circular; int pc is
                                            * the closer end state.  See session notes. */
            if ((unsigned char)t != (unsigned char)tolower(*text))
                return 0;
            if (*pat++ != 0) {             /* pattern continues -> advance both, loop */
                text++;
                continue;
            }
            return 1;
        }
    }
ret0:
    return 0;                              /* oracle .LBF0: shared v0=0 falling into the epilogue */
}
