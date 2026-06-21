/* syslib/psx/libc/SPRINTF.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\syslib\psx\SPRINTF.obj ; archive C:\nfs4\SYSLIB\PSX\LIBC.LIB (xlsx col10)
 *               == libc.lib(SPRINTF.OBJ). proto: int sprintf(char *s, char *fmt, ...) [stdio.h]
 *   1 fn @0x800E44BC (2192 bytes) -- the libc printf-family FORMAT-STRING PARSER.
 *   FULL reconstruction of the actual code (Ghidra @141961 + disasm-v3); NOT a wrapper.
 *
 *   Flags (Ghidra local_40 byte0): 1='-'(left) 2='+' 4='#'(alt) 8='0'(zeropad) 0x10=prec-given
 *     0x20='h'(short) 0x40='l'(long) 0x80='L'.  sign char = local_40 byte1.  width/prec = local_3c/38.
 *   Numbers built backward into a scratch buffer, padded to width, emitted via memmove.
 *   Conversions: c d i o p u x X s n ; length-mods h l L.  Variadic frame (local_30/local_res8) == va_list.
 *
 *   VERIFY: behaviorally faithful but a large NEAR-MISS WALL (~436/558 insns; the recon is ~120 insns
 *   short of the oracle).  This is the biggest libc fn (a 558-insn printf-family parser).  A byte-match
 *   needs a dedicated focused pass: NFS4 uses a packed FLAGS-BYTE (local_40: 1='-' 2='+' 4='#' 8='0'
 *   0x10=prec 0x20='h' 0x40='l' 0x80='L'), which THIS code already models (so SOTN's bitfield-struct
 *   form, sotn-psxsdk/src/main/psxsdk/libc/sprintf.c, is the WRONG shape here -- kept only as a structural
 *   cross-reference for the conversion/width/precision logic).  The gap is in the exact conversion-loop
 *   shapes + width/precision padding + register allocation across 558 insns -- deferred as a wall, the
 *   current TU is the clearest faithful behavioral form.
 */
#include <stdarg.h>
#include <stddef.h>   /* NULL */

extern "C" int    strlen(const char *s);                        /* libc C27   */
extern "C" void  *memchr(const void *s, int c, unsigned n);     /* libc C46   */
extern "C" void  *memmove(void *d, const void *s, unsigned n);  /* libc MEMMOVE */

extern "C" int sprintf(char *s, const char *fmt, ...)   /* @0x800E44BC */
{
    va_list ap;
    va_start(ap, fmt);
    const char *p = fmt;
    int out = 0;                              /* chars written (Ghidra iVar7) */

    while (*p) {
        if (*p != '%') { s[out++] = *p++; continue; }
        ++p;                                  /* past '%' */

        unsigned flags = 0;                   /* local_40 byte0 */
        char     signc = 0;                   /* local_40 byte1 (sign/space char) */
        int      width = 0, prec = 0;         /* local_3c, local_38 */

        for (;; ++p) {                        /* flags */
            if      (*p == '-') flags |= 1;
            else if (*p == '+') flags |= 2;
            else if (*p == ' ') signc = ' ';
            else if (*p == '#') flags |= 4;
            else if (*p == '0') flags |= 8;
            else break;
        }
        if (*p == '*') { width = va_arg(ap, int); ++p;        /* width */
                         if (width < 0) { width = -width; flags |= 1; } }
        else while ((unsigned)(*p - '0') < 10) width = width * 10 + (*p++ - '0');

        if (*p == '.') {                      /* precision */
            ++p;
            if (*p == '*') { prec = va_arg(ap, int); ++p; }
            else while ((unsigned)(*p - '0') < 10) prec = prec * 10 + (*p++ - '0');
            if (prec >= 0) flags |= 0x10;
        }
        if (flags & 1) flags &= ~8u;          /* left-align cancels zero-pad */

        char  buf[24];
        char *t  = buf + sizeof(buf);         /* number built backward (Ghidra s_00) */
        const char *bp = t;                   /* source span to emit */
        unsigned n = 0;
        const char *digits;
        bool emit = true;
        int spec;

        for (;;) {                            /* length-mods, then one conversion */
            spec = (unsigned char)*p++;
            if (spec == 'L') { flags |= 0x80; continue; }
            if (spec == 'h') { flags |= 0x20; continue; }
            if (spec == 'l') { flags |= 0x40; continue; }
            break;
        }

        switch (spec) {
        case 'c':
            buf[0] = (char)va_arg(ap, int); bp = buf; n = 1; break;

        case 'd': case 'i': {
            unsigned uv = (unsigned)va_arg(ap, int);
            if (flags & 0x20) uv = (unsigned)(short)uv;
            if ((int)uv < 0) { uv = -uv; signc = '-'; }
            else if (flags & 2) signc = '+';
            if (!(flags & 0x10)) { if (flags & 8) prec = width; if (prec < 1) prec = 1; }
            n = 0;
            while (uv) { *--t = (char)('0' + uv % 10); uv /= 10; ++n; }
            for (; (int)n < prec; ++n) *--t = '0';
            if (signc) { *--t = signc; ++n; }
            bp = t; break; }

        case 'u': {
            unsigned uv = (unsigned)va_arg(ap, int);
            if (flags & 0x20) uv &= 0xffff;
            if (!(flags & 0x10)) { if (flags & 8) prec = signc ? width - 1 : width; if (prec < 1) prec = 1; }
            n = 0;
            while (uv) { *--t = (char)('0' + uv % 10); uv /= 10; ++n; }
            for (; (int)n < prec; ++n) *--t = '0';
            if (signc) { *--t = signc; ++n; }
            bp = t; break; }

        case 'o': {
            unsigned uv = (unsigned)va_arg(ap, int);
            if (flags & 0x20) uv &= 0xffff;
            if (!(flags & 0x10)) { if (flags & 8) prec = width; if (prec < 1) prec = 1; }
            n = 0;
            for (; uv; uv >>= 3) { *--t = (char)('0' + (uv & 7)); ++n; }
            if ((flags & 4) && n && *t != '0') { *--t = '0'; ++n; }
            for (; (int)n < prec; ++n) *--t = '0';
            bp = t; break; }

        case 'p': prec = 8; flags |= 0x50;            /* fallthrough */
        case 'X': digits = "0123456789ABCDEF"; goto hexconv;
        case 'x': digits = "0123456789abcdef";
        hexconv: {
            unsigned uv = (unsigned)va_arg(ap, int);
            if (flags & 0x20) uv &= 0xffff;
            if (!(flags & 0x10)) { if (flags & 8) prec = (flags & 4) ? width - 2 : width; if (prec < 1) prec = 1; }
            n = 0;
            for (; uv; uv >>= 4) { *--t = digits[uv & 0xf]; ++n; }
            for (; (int)n < prec; ++n) *--t = '0';
            if (flags & 4) { *--t = (char)spec; *--t = '0'; n += 2; }
            bp = t; break; }

        case 's': {
            const char *str = (const char *)va_arg(ap, void *);
            bp = str;
            if (flags & 4) { n = (unsigned char)*str; ++bp;
                             if ((flags & 0x10) && (int)prec < (int)n) n = prec; }
            else if (flags & 0x10) { void *e = memchr(str, '\0', prec);
                                     n = e ? (unsigned)((const char *)e - str) : (unsigned)prec; }
            else n = strlen(str);
            break; }

        case 'n': {
            int *pn = (int *)va_arg(ap, void *);
            if (flags & 0x20) *(short *)pn = (short)out; else *pn = out;
            emit = false; break; }

        default:
            if (spec != '%') { va_end(ap); s[out] = '\0'; return out; }   /* unknown -> stop */
            s[out++] = '%'; emit = false; break;                          /* %% */
        }

        if (emit) {
            if ((int)n < width && !(flags & 1))
                while ((int)n < width) { s[out++] = ' '; --width; }
            memmove(s + out, bp, n); out += n;
            for (; (int)n < width; ++n) s[out++] = ' ';
        }
    }
    s[out] = '\0';
    va_end(ap);
    return out;
}
