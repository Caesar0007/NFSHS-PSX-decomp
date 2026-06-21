/* eaclib/psx/eacpsxz/wildcard.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
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
extern "C" char *strrchr(const char *s, int c);   /* libc C31.obj, BIOS A0:0x1F */
extern "C" int   tolower(int c);                   /* libc C38.obj, BIOS A0:0x26 */

extern "C" char *strrstr (char *s, char *set);    /* @0x800E8940 */
extern "C" int   wildcard(char *text, char *pat); /* @0x800E89BC */

/* strrstr @0x800E8940 : rightmost position in `s` of any char of `set` (0 if none). */
extern "C" char *strrstr(char *s, char *set)
{
    char *best = 0;
    for (; *set; set++) {
        char *p = strrchr(s, *set);     /* libc strrchr, BIOS A0:0x1F */
        if (best < p)                    /* keep the rightmost (max) hit */
            best = p;
    }
    return best;
}

/* wildcard @0x800E89BC : boolean+glob pattern match, 1 == match. */
extern "C" int wildcard(char *text, char *pat)
{
    static const char kOps[] = "&|!~^";   /* @0x8013DC48 (wildcard.obj-local rodata) */
    char *op = strrstr(pat, (char *)kOps);

    if (op) {                              /* split at the rightmost operator */
        char ch = *op;
        int  r;
        *op = 0;                           /* NUL it so each half is a standalone pattern */
        if (ch == '&') {                   /* AND */
            r = wildcard(text, pat) ? (wildcard(text, op + 1) > 0) : 0;
        } else if (ch == '^') {            /* XOR */
            int l = wildcard(text, pat);
            r = l ^ wildcard(text, op + 1);
        } else {                           /* '|','!','~' all == OR */
            r = (wildcard(text, pat) != 0 || wildcard(text, op + 1) != 0) ? 1 : 0;
        }
        *op = ch;                          /* restore the operator char */
        return r;
    }

    /* no operator -> leaf glob match, anchored at the start of `text` */
    for (;;) {
        char pc = *pat;
        if (pc == '*') {                   /* glob: try the rest at each text position */
            pat++;
            for (;;) {
                if (wildcard(text, pat))
                    return 1;
                if (*text == 0)
                    return 0;
                text++;
            }
        } else if (pc == '?') {            /* any one non-NUL char */
            if (*text == 0)
                return 0;
            text++; pat++;
        } else if (pc == '#') {            /* any one digit (ctype &4) */
            char tc = *text;
            if (!(tc >= '0' && tc <= '9'))
                return 0;
            text++; pat++;
        } else if (pc == '~') {            /* NOT the rest */
            return wildcard(text, pat + 1) < 1;
        } else {                           /* case-insensitive literal compare */
            if ((tolower(pc) & 0xFF) != (tolower(*text) & 0xFF))
                return 0;
            if (*pat == 0)                 /* pattern exhausted -> match */
                return 1;
            pat++; text++;
        }
    }
}
