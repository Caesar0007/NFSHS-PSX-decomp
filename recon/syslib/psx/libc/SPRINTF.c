/* syslib/psx/libc/SPRINTF.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 * Source obj: nfs4\syslib\psx\SPRINTF.obj; libc.lib(SPRINTF.OBJ).
 *
 * The format parser's source shape is shared with the Psy-Q SDK reconstruction at
 * sotn-decomp/src/main/psxsdk/libc/sprintf.c.  In particular it uses a 0x200-byte
 * conversion buffer, copies a zero printf_info template for every conversion, and
 * derives the backwards number-buffer pointer from the on-stack va_list.
 */
typedef enum { false = 0, true = 1 } bool;
typedef char *va_list;
#define va_start(ap, last) ((ap) = (char *)&(last) + 4)
#define va_arg(ap, type)   (*(type *)(((ap) += 4) - 4))
#define NULL ((void *)0)

extern int   strlen(const char *s);
extern void *memchr(const void *s, int c, unsigned n);
extern void *memmove(void *d, const void *s, unsigned n);

typedef struct printf_info {
    bool leftJustified : 1;
    bool prependPlus : 1;
    bool alternativeForm : 1;
    bool leadingZeros : 1;
    bool usePrecision : 1;
    bool isHalf : 1;
    bool isLong : 1;
    bool isLongLong : 1;
    char leadingChar;
    int width;
    int precision;
} printf_info;

extern printf_info D_8012348C;

extern int sprintf(char *out, signed char *f, ...)
{
    register int flagZero = '0';
    char buf[0x200];
    printf_info info;
    va_list args;
    char *hexChars;
    int written;
    int num;
    int len;
    char *bufPtr;
    int ch;

    va_start(args, f);
    ch = *f;
    written = 0;
    for (; ch = *f, ch != 0; ++f) {
        if (ch != '%') {
            out[written++] = ch;
            continue;
        }
        info = D_8012348C;

        while (true) {
            ch = *++f;
            if (ch == '-') {
                info.leftJustified = true;
            } else if (ch == '+') {
                info.prependPlus = true;
            } else if (ch == ' ') {
                info.leadingChar = ' ';
            } else if (ch == '#') {
                info.alternativeForm = true;
            } else if (ch == flagZero) {
                info.leadingZeros = true;
            } else {
                break;
            }
        }

        if (ch == '*') {
            info.width = va_arg(args, int);
            if (info.width < 0) {
                info.width = -info.width;
                info.leftJustified = true;
            }
            ch = *++f;
        } else {
            while (ch >= '0' && ch <= '9') {
                info.width = (info.width * 10) + (ch - '0');
                ch = *++f;
            }
        }
        if (ch == '.') {
            ch = *++f;
            if (ch == '*') {
                info.precision = va_arg(args, int);
                ch = *++f;
            } else {
                while (ch >= '0' && ch <= '9') {
                    info.precision = (info.precision * 10) + (ch - '0');
                    ch = *++f;
                }
            }
            if (info.precision >= 0)
                info.usePrecision = true;
        }

        /* This relation deliberately keeps args on the stack and produces buf+0x1FC. */
        bufPtr = (char *)&args - sizeof(printf_info) - 4;

        if (info.leftJustified)
            info.leadingZeros = false;

    conversion:
        switch (ch) {
        case 'h':
            info.isHalf = true;
            ch = *++f;
            goto conversion;

        case 'l':
            info.isLong = true;
            ch = *++f;
            goto conversion;

        case 'L':
            info.isLongLong = true;
            ch = *++f;
            goto conversion;

        case 'd':
        case 'i':
            num = va_arg(args, int);
            do {
                if (info.isHalf)
                    num = (short)num;
            } while (0);
            if (num < 0) {
                num = -num;
                info.leadingChar = '-';
            } else {
                do {
                    if (info.prependPlus)
                        info.leadingChar = '+';
                } while (0);
            }
            goto printDec;

        case 'u':
            num = va_arg(args, unsigned int);
            do {
                if (info.isHalf)
                    num = (unsigned short)num;
            } while (0);
            info.leadingChar = '\0';
        printDec:
            if (!info.usePrecision) {
                if (info.leadingZeros) {
                    info.precision = info.width;
                    if (info.leadingChar != '\0')
                        info.precision = info.width - 1;
                }
                if (info.precision <= 0)
                    info.precision = 1;
            }
            len = 0;
            while (num != 0) {
                *--bufPtr = (num % 10U) + '0';
                num /= 10U;
                len++;
            }
            while (len < info.precision) {
                *--bufPtr = '0';
                len++;
            }
            if (info.leadingChar != '\0') {
                *--bufPtr = info.leadingChar;
                len++;
            }
            break;

        case 'o':
            num = va_arg(args, unsigned int);
            do {
                if (info.isHalf)
                    num = (unsigned short)num;
            } while (0);
            if (!info.usePrecision) {
                if (info.leadingZeros)
                    info.precision = info.width;
                if (info.precision <= 0)
                    info.precision = 1;
            }
            len = 0;
            while (num != 0) {
                *--bufPtr = (num % 8U) + '0';
                num /= 8U;
                len++;
            }
            if (info.alternativeForm && len != 0 && *bufPtr != '0') {
                *--bufPtr = '0';
                len++;
            }
            while (len < info.precision) {
                *--bufPtr = '0';
                len++;
            }
            break;

        case 'p':
            info.precision = 8;
            info.usePrecision = true;
            info.isLong = true;
            /* fallthrough */
        case 'X':
            hexChars = "0123456789ABCDEF";
            goto printHex;
        case 'x':
            hexChars = "0123456789abcdef";
        printHex:
            num = va_arg(args, unsigned int);
            do {
                if (info.isHalf)
                    num = (unsigned short)num;
            } while (0);
            if (!info.usePrecision) {
                if (info.leadingZeros) {
                    info.precision = info.width;
                    if (info.alternativeForm)
                        info.precision = info.width - 2;
                }
                if (info.precision <= 0)
                    info.precision = 1;
            }
            len = 0;
            while (num != 0) {
                *--bufPtr = hexChars[num % 16U];
                num /= 16U;
                len++;
            }
            while (len < info.precision) {
                *--bufPtr = '0';
                len++;
            }
            if (info.alternativeForm) {
                *--bufPtr = ch;
                *--bufPtr = '0';
                len += 2;
            }
            break;

        case 'c':
            *--bufPtr = (char)va_arg(args, int);
            len = 1;
            break;

        case 's':
            bufPtr = va_arg(args, char *);
            if (info.alternativeForm) {
                len = (unsigned char)*bufPtr++;
                if (info.usePrecision && info.precision < len)
                    len = info.precision;
            } else if (!info.usePrecision) {
                len = strlen(bufPtr);
            } else {
                char *ptr = (char *)memchr(bufPtr, 0, info.precision);
                len = ptr - bufPtr;
                if (ptr == NULL)
                    len = info.precision;
            }
            break;

        case 'n':
            bufPtr = va_arg(args, char *);
            if (info.isHalf)
                *(short *)bufPtr = (short)written;
            else if (info.isLong)
                *(int *)bufPtr = written;
            else if (info.isLongLong)
                *(int *)bufPtr = written;
            else
                *(int *)bufPtr = written;
            continue;

        default:
            if (ch == '%') {
                out[written++] = ch;
                continue;
            }
            goto end;
        }
        if (len < info.width && !info.leftJustified) {
            while (len < info.width) {
                out[written++] = ' ';
                info.width--;
            }
        }
        memmove(&out[written], bufPtr, len);
        written += len;
        while (len < info.width) {
            out[written++] = ' ';
            len++;
        }
    }
end:
    out[written] = 0;
    return written;
}
