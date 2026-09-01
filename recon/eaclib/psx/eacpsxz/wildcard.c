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
extern char _ctype_[];                     /* canonical PsyQ CTYPE.H; CTYPE0.obj @0x801371D0 */

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
    /* MATCH (w33-a4, the other half of 14->0): the leaf scanner is a LABEL+GOTO loop, not a
     * `for(;;)`.  This is NOT about loop.c's transforms here -- it is about flow.c's REF WEIGHTING:
     * `REG_N_REFS += loop_depth`, and loop_depth only rises inside a NOTE_INSN_LOOP_BEG/END pair.
     * With the `for(;;)` every in-loop reference counts double, and the byte-`pc` fix above adds one
     * more in-loop `pat` read (retail's extra `lbu`), which pushed pat to 32 refs/76 insns
     * (priority 2.105) just past text's 36/87 (2.069) and swapped $s1/$s2 across the whole body
     * (68 diffs).  Unweighted the same shape is text 25/87 = 1.15 vs pat 20/76 = 1.05, i.e. retail's
     * order.  Moving `pat++` into the shared `join` tail also fixes the ratio but costs the '#'
     * arm's load-delay fill (151 insns, oracle fills it with `addiu s2,s2,1`) -- retail really does
     * have a `pat++` in BOTH the '?' and '#' arms, so the goto-loop is the correct lever.
     * (allocno priority = floor_log2(n_refs)*n_refs/live_length, gcc-2.8 global.c allocno_compare.) */
loop:
    {
        unsigned char pc = *pat;           /* v1.  MATCH (w33-a4, half of the 14->0 fix): pc must
                                            * be a BYTE type.  As `int pc` the `tolower(*pat)` read
                                            * in the literal arm CSEs into a copy of pc, which then
                                            * carries pc's $a0 preference into the allocator (pc
                                            * lands in $a0 and every compare uses it); the byte type
                                            * blocks that CSE, so the literal arm re-emits retail's
                                            * fresh `lbu a0,0(s2)` and pc stays in $v1. */
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
            goto loop;
        }
        if (pc == '~')                     /* NOT the rest */
            goto notleaf;
        {                                  /* case-insensitive literal compare */
            int t = tolower(*pat);         /* s0; tolower'd FIRST (retail: two `jal tolower` with
                                            * the first result parked in $s0 in the second call's
                                            * delay slot). */
            if ((unsigned char)t != (unsigned char)tolower(*text))
                return 0;
            if (*pat++ != 0) {             /* pattern continues -> advance both, loop */
                text++;
                goto loop;
            }
            return 1;
        }
    }
ret0:
    return 0;                              /* oracle .LBF0: shared v0=0 falling into the epilogue */
}
