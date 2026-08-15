# 0 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
# 89 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
typedef int (*CdlCB)(int intr, unsigned char *result);





extern volatile unsigned char *D_8013C20C;
extern volatile unsigned char *D_8013C210;
extern volatile unsigned char *D_8013C214;
extern volatile unsigned char *D_8013C218;
extern volatile unsigned int *D_8013C21C;
extern volatile unsigned short*D_8013C220;
extern volatile unsigned int *D_8013C240;
extern volatile unsigned int *D_8013C244;
extern volatile unsigned int *D_8013C248;
extern volatile unsigned int *D_8013C24C;
extern volatile unsigned int *D_8013C250;







extern int VSync(int mode);
extern int CheckCallback(void);
extern void ResetCallback(void);
extern void InterruptCallback(int n, void (*cb)(void));
extern int puts(const char *s);
extern int printf(const char *fmt, ...);

extern void CD_flush(void);
extern int CD_sync(int mode, unsigned char *result);
extern void _cd_intr_dispatch(void);





extern int CD_cbsync;
extern int CD_cbready;
extern int CD_debug;
extern int CD_status;
extern int CD_status1;
extern unsigned char CD_pos[4];
extern unsigned char CD_mode;
extern unsigned char CD_com;
extern int CD_nopen;



struct CD_intr { unsigned char sync, ready, c; };
typedef struct CD_intr CD_intr;
extern volatile CD_intr D_8013C224;
# 155 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
extern unsigned char D_8014899C[8];
extern unsigned char D_801489A4[8];
extern unsigned char D_801489AC[8];
unsigned char D_8014899C[8];
unsigned char D_801489A4[8];
unsigned char D_801489AC[8];




extern int D_801489B4;
extern int D_801489B8;
extern const char *D_801489BC;




typedef struct { int deadline; int counter; char *name; } CD_alarm;



extern char *CD_comstr[];
extern char *CD_intstr[];


extern int _cd_result_flag[];
extern int _cd_param_count[];
static const int _cd_int3_ack[32] = {
    0,0,0,0,0,0,0,1, 1,1,1,0,0,0,0,0, 0,0,1,0,0,1,1,0, 0,0,1,0,0,0,0,0 };
static const int _cd_status_ok[32] = {
    1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1, 0,0,1,1,1,1,1,1, 1,1,1,1,1,1,1,1 };
# 197 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
static inline void _memcpy8(unsigned char *dst, unsigned char *src)
{
    unsigned char *d;
    unsigned char *s;
    int count;
    int end;

    d = dst;
    s = src;
    if (d == 0)
        return;
    count = 7;
    end = -1;
    do {
        *d++ = *s++;
    } while (--count != end);
}
# 265 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
extern int CD_get_intr(void)
{
    volatile unsigned char nReg;
    volatile unsigned char result[8];
    int i;
    int j;

    int bHasError;
    volatile unsigned char *p;

    (*D_8013C20C) = 1;
    p = D_8013C218;
    nReg = *p & 7;
    if (nReg == 0)
        return 0;

    bHasError = 0;
    while (nReg != (*p & 7))
        nReg = *p & 7;

    for (i = 0; i < 8; i++) {
        volatile unsigned char *q = &result[i];
        if (((*D_8013C20C) & 0x20) == 0)
            break;
        *q = (*D_8013C210);
    }
    __asm__("" : "=r"(i) : "0"(i));
    for (j = i; j < 8; j++)
        result[j] = 0;

    (*D_8013C20C) = 1; (*D_8013C218) = 7; (*D_8013C214) = 7;

    if ((*(const unsigned char *)&nReg) != 3 || _cd_status_ok[CD_com]) {
        if (!(CD_status & 0x10) && (result[0] & 0x10))
            CD_nopen++;
        CD_status = result[0];
        CD_status1 = result[1];
        bHasError = CD_status & 0x1d;
    }
# 314 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
    __asm__("" : : "i"(0));
    if ((*(const unsigned char *)&nReg) == 5) {
        if (CD_debug > 0)
            puts("DiskError: ");
        if (CD_debug > 0)
            printf("com=%s,code=(%02x:%02x)\n", CD_comstr[CD_com], CD_status, CD_status1);
    }

    switch (nReg) {
    case 3:
        if (bHasError) {
            D_8013C224.sync = 5;
            _memcpy8(D_8014899C, (unsigned char *)result);
            return 2;
        }
        if (_cd_int3_ack[CD_com]) {
            D_8013C224.sync = 3;
            _memcpy8(D_8014899C, (unsigned char *)result);
            return 1;
        }
        D_8013C224.sync = 2;
        _memcpy8(D_8014899C, (unsigned char *)result);
        return 2;
    case 2:
        D_8013C224.sync = bHasError ? 5 : 2;
        _memcpy8(D_8014899C, (unsigned char *)result);
        return 2;
    case 1:
        if (bHasError && i == 1)
            bHasError = 0;
        {
            unsigned char rv = bHasError ? 5 : 1;
            volatile unsigned char *b = (volatile unsigned char *)&D_8013C224;
            __asm__("" : "=r"(b) : "0"(b));
            b[1] = rv;
        }
        _memcpy8(D_801489A4, (unsigned char *)result);
        (*D_8013C20C) = 0; (*D_8013C218) = 0;
        return 4;
    case 4:






        {
            volatile unsigned char *b = (volatile unsigned char *)&D_8013C224;
            __asm__("" : "=r"(b) : "0"(b));
            b[2] = 4;
            b[1] = b[2];
        }
        _memcpy8(D_801489AC, (unsigned char *)result);
        _memcpy8(D_801489A4, (unsigned char *)result);
        return 4;
    case 5:


        {
            volatile unsigned char *b = (volatile unsigned char *)&D_8013C224;
            __asm__("" : "=r"(b) : "0"(b));
            b[1] = 5;
            b[0] = b[1];
        }
        _memcpy8(D_8014899C, (unsigned char *)result);
        _memcpy8(D_801489A4, (unsigned char *)result);
        return 6;
    default:
        puts("CDROM: unknown intr");
        printf("(%d)\n", nReg);
        return 0;
    }
}



static inline void set_alarm(const char *name)
{
    (*(CD_alarm *)&D_801489B4).deadline = VSync(-1) + 0x3c0;
    (*(CD_alarm *)&D_801489B4).counter = 0;
    (*(CD_alarm *)&D_801489B4).name = (char *)name;
}







static inline int _spin_bump(void)
{
    int c = (*(CD_alarm *)&D_801489B4).counter;
    int old = c++;
    (*(CD_alarm *)&D_801489B4).counter = c;
    return old;
}

static inline int get_alarm(void)
{
    if ((*(CD_alarm *)&D_801489B4).deadline < VSync(-1) || _spin_bump() > 0x3c0000) {




        puts("CD timeout: ");
        printf("%s:(%s) Sync=%s, Ready=%s\n", (*(CD_alarm *)&D_801489B4).name,
               CD_comstr[CD_com], CD_intstr[D_8013C224.sync], CD_intstr[D_8013C224.ready]);
        CD_flush();
        return -1;
    }
    return 0;
}

static inline void callback(void)
{
    int interrupt;
    unsigned char restore;

    restore = (*D_8013C20C) & 3;
    for (;;) {
        interrupt = CD_get_intr();
        if (interrupt == 0)
            break;
        if ((interrupt & 4) && CD_cbready != 0)
            ((CdlCB)CD_cbready)(D_8013C224.ready, D_801489A4);
        if ((interrupt & 2) && CD_cbsync != 0)
            ((CdlCB)CD_cbsync)(D_8013C224.sync, D_8014899C);
    }
    (*D_8013C20C) = restore;
}
# 454 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
extern int CD_sync(int mode, unsigned char *result)
{
    char **cmdNames;
    char **statusNames;
    volatile CD_intr *intr;
    volatile unsigned char *ready;
    int interrupt;
    unsigned char restore;
    unsigned char sync;

    (*(CD_alarm *)&D_801489B4).deadline = VSync(-1) + 0x3c0;
    cmdNames = CD_comstr;
    statusNames = CD_intstr;
    intr = &D_8013C224;
    ready = &intr->ready;
    (*(CD_alarm *)&D_801489B4).counter = 0;
    (*(CD_alarm *)&D_801489B4).name = "CD_sync";

    for (;;) {
        int alarm;
        if ((*(CD_alarm *)&D_801489B4).deadline < VSync(-1) || _spin_bump() > 0x3c0000) {




            int syncIdx;
            char *readyName;
            puts("CD timeout: ");
            syncIdx = intr->sync;
            readyName = statusNames[intr->ready];
            printf("%s:(%s) Sync=%s, Ready=%s\n", (*(CD_alarm *)&D_801489B4).name,
                   cmdNames[CD_com], statusNames[syncIdx], readyName);
            CD_flush();
            alarm = -1;
        } else {
            alarm = 0;
        }
        if (alarm != 0)
            return -1;

        if (CheckCallback()) {
            restore = (*D_8013C20C) & 3;
            for (;;) {
                interrupt = CD_get_intr();
                if (interrupt == 0)
                    break;
                if ((interrupt & 4) && CD_cbready != 0)
                    ((CdlCB)CD_cbready)(*ready, D_801489A4);
                if ((interrupt & 2) && CD_cbsync != 0)
                    ((CdlCB)CD_cbsync)(intr->sync, D_8014899C);
            }
            (*D_8013C20C) = restore;
        }

        {
# 523 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
            int syncv;
            sync = intr->sync;
            syncv = sync;
            __asm__("" : "=r"(syncv) : "0"(syncv));
            if (syncv == 2 || syncv == 5) {
                intr->sync = 2;
                _memcpy8(result, D_8014899C);
                return syncv;
            }
        }
        if (mode != 0)
            return 0;
    }
}
# 560 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
extern int CD_ready(int mode, unsigned char *result)
{
    char **cmdNames;
    char **statusNames;
    volatile CD_intr *intr;
    volatile unsigned char *readyp;
    volatile unsigned char *cflag;
    int interrupt;
    unsigned char restore;
    int c;
    int ready;

    (*(CD_alarm *)&D_801489B4).deadline = VSync(-1) + 0x3c0;
    cmdNames = CD_comstr;
    statusNames = CD_intstr;
    intr = &D_8013C224;
    readyp = &intr->ready;
    cflag = &intr->c;
    (*(CD_alarm *)&D_801489B4).counter = 0;
    (*(CD_alarm *)&D_801489B4).name = "CD_ready";

    for (;;) {
        int alarm;
        if ((*(CD_alarm *)&D_801489B4).deadline < VSync(-1) || _spin_bump() > 0x3c0000) {

            int syncIdx;
            char *readyName;
            puts("CD timeout: ");
            syncIdx = intr->sync;
            readyName = statusNames[intr->ready];
            printf("%s:(%s) Sync=%s, Ready=%s\n", (*(CD_alarm *)&D_801489B4).name,
                   cmdNames[CD_com], statusNames[syncIdx], readyName);
            CD_flush();
            alarm = -1;
        } else {
            alarm = 0;
        }
        if (alarm != 0)
            return -1;

        if (CheckCallback()) {
            restore = (*D_8013C20C) & 3;
            for (;;) {
                interrupt = CD_get_intr();
                if (interrupt == 0)
                    break;
                if ((interrupt & 4) && CD_cbready != 0)
                    ((CdlCB)CD_cbready)(*readyp, D_801489A4);
                if ((interrupt & 2) && CD_cbsync != 0)
                    ((CdlCB)CD_cbsync)(intr->sync, D_8014899C);
            }
            (*D_8013C20C) = restore;
        }

        c = *cflag;
        if (c != 0) {
            intr->c = 0;
            _memcpy8(result, D_801489AC);
            return c;
        }
        ready = cflag[-1];
        if (ready != 0) {
            intr->ready = 0;
            _memcpy8(result, D_801489A4);
            return ready;
        }
        if (mode != 0)
            return 0;
    }
}







extern int CD_cw(unsigned char com, unsigned char *param, unsigned char *result, int arg3)
{
    volatile CD_intr *ip;
    char **cmdNames;
    volatile CD_intr *ep;
    int i;
    int ret;
    int *tbl;
    int *cnt;

    if (CD_debug > 1)
        printf("%s...\n", CD_comstr[com]);
    if (_cd_param_count[com] != 0 && param == 0) {
        if (CD_debug > 0)
            printf("%s: no param\n", CD_comstr[com]);
        return -2;
    }
    CD_sync(0, 0);
    if (com == 2)
        for (i = 0; i < 4; i++)
            CD_pos[i] = param[i];
    if (com == 0xe)
        CD_mode = param[0];
# 692 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
    ip = &D_8013C224;
    __asm__("" : "=r"(ip) : "0"(ip));
    ip->sync = 0;
    tbl = _cd_result_flag;
    if (*(int *)((com << 2) + (int)_cd_result_flag))
        ip->ready = 0;
    (*D_8013C20C) = 0;
# 730 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
    cnt = tbl + 0x40;
    i = 0;
    if (cnt[com] > 0)
        do {
            (*D_8013C214) = param[i];
            i++;
        } while (i < cnt[com]);
    CD_com = (unsigned char)com;
    (*D_8013C210) = CD_com;
    if (arg3 != 0)
        return 0;
# 764 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
    (*(CD_alarm *)&D_801489B4).deadline = VSync(-1) + 0x3c0;
    cmdNames = CD_comstr;
    (*(CD_alarm *)&D_801489B4).counter = 0;
    (*(CD_alarm *)&D_801489B4).name = "CD_cw";
    while (D_8013C224.sync == 0) {
        int alarm;
        if ((*(CD_alarm *)&D_801489B4).deadline < VSync(-1) || _spin_bump() > 0x3c0000) {
            int syncIdx;
            char *readyName;
            puts("CD timeout: ");
            syncIdx = D_8013C224.sync;
            readyName = CD_intstr[D_8013C224.ready];
            printf("%s:(%s) Sync=%s, Ready=%s\n", (*(CD_alarm *)&D_801489B4).name,
                   cmdNames[CD_com], CD_intstr[syncIdx], readyName);
            CD_flush();
            alarm = -1;
        } else {
            alarm = 0;
        }
        if (alarm != 0)
            return -1;
        if (CheckCallback())
            callback();
    }
    _memcpy8(result, D_8014899C);
# 801 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
    ret = 0;
    ep = &D_8013C224;
    __asm__("" : "=r"(ep) : "0"(ep));



    if (*(const unsigned char *)&ep->sync == 5) {
        ret = -1;
        __asm__("" : : "i"(0));



    }
    return ret;
}


extern void CD_flush(void)
{
# 844 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
    volatile unsigned char *state;
    volatile unsigned char *reg;
    unsigned char c;
    (*D_8013C20C) = 1;
    while ((*D_8013C218) & 7) {
        (*D_8013C20C) = 1;
        (*D_8013C218) = 7;
        (*D_8013C214) = 7;
    }
    state = &D_8013C224.sync;
    __asm__("" : "=r"(state) : "0"(state));
    state[2] = 0;
    c = state[2];
    __asm__("" : "=r"(c) : "0"(c));
    state[1] = c;
    reg = D_8013C20C;
    state[0] = 2;
    *reg = 0;
    (*D_8013C218) = 0;
    *D_8013C21C = 0x1325;
}
# 873 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
extern int CD_initvol(void)
{
    unsigned char vol[4];
    if (D_8013C220[0x1b8 / 2] == 0) {
        if (D_8013C220[0x1ba / 2] == 0) {
            D_8013C220[0x180 / 2] = 0x3fff;
            D_8013C220[0x182 / 2] = 0x3fff;
        }
    }
    D_8013C220[0x1b0 / 2] = 0x3fff;
    D_8013C220[0x1b2 / 2] = 0x3fff;
    D_8013C220[0x1aa / 2] = 0xc001;
    vol[0] = vol[2] = 0x80;
    vol[1] = vol[3] = 0;
    (*D_8013C20C) = 2;
    (*D_8013C214) = vol[0];
    (*D_8013C218) = vol[1];
    (*D_8013C20C) = 3;
    (*D_8013C210) = vol[2];
    (*D_8013C214) = vol[3];
    (*D_8013C218) = 0x20;
    return 0;
}


extern int CD_initintr(void)
{
    CD_cbready = 0;
    CD_cbsync = 0;
    CD_status1 = 0;
    CD_status = 0;
    ResetCallback();
    InterruptCallback(2, _cd_intr_dispatch);


}


extern int D_8013C228;
# 923 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
extern int CD_init_80108140(void)
{
# 938 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
    volatile unsigned char *state;
    volatile unsigned char *reg;
    unsigned char c;
    puts("CD_init:");
    printf("addr=%08x\n", &D_8013C228);
    CD_com = 0;
    CD_mode = 0;
    CD_cbready = 0;
    CD_cbsync = 0;
    CD_status1 = 0;
    CD_status = 0;
    ResetCallback();
    InterruptCallback(2, _cd_intr_dispatch);

    (*D_8013C20C) = 1;
    while ((*D_8013C218) & 7) {
        (*D_8013C20C) = 1;
        (*D_8013C218) = 7;
        (*D_8013C214) = 7;
    }
    state = &D_8013C224.sync;
    __asm__("" : "=r"(state) : "0"(state));
    state[2] = 0;
    c = state[2];
    __asm__("" : "=r"(c) : "0"(c));
    state[1] = c;
    reg = D_8013C20C;
    state[0] = 2;
    *reg = 0;
    (*D_8013C218) = 0;
    *D_8013C21C = 0x1325;

    CD_cw(1, 0, 0, 0);
    if (CD_status & 0x10)
        CD_cw(1, 0, 0, 0);
    if (CD_cw(0xa, 0, 0, 0))
        return -1;
    if (CD_cw(0xc, 0, 0, 0))
        return -1;
# 994 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
    if (CD_sync(0, 0) != 2) {
        __asm__("" : : "i"(0));
        return -1;
    }
    __asm__("" : : "i"(0));
    return 0;
}
# 1013 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
extern int CD_datasync(int mode)
{
    char **comstr;
    volatile unsigned char *intr;
    char **intstr;
    int spinmax;
    int ret;

    (*(CD_alarm *)&D_801489B4).deadline = VSync(-1) + 0x3c0;
    spinmax = 0x3c0000;
    comstr = CD_comstr;
    intr = &D_8013C224.sync;
    intstr = CD_intstr;
    (*(CD_alarm *)&D_801489B4).counter = 0;
    (*(CD_alarm *)&D_801489B4).name = "CD_datasync";
    do {
        int status;
        if (VSync(-1) > (*(CD_alarm *)&D_801489B4).deadline || _spin_bump() > spinmax) {
# 1053 "C:\\Temp\\nfs4-decomp\\recon\\syslib\\psx\\libcd\\drv.c"
            int syncIdx;
            char *readyName;
            puts("CD timeout: ");
            syncIdx = intr[0];
            readyName = intstr[intr[1]];
            printf("%s:(%s) Sync=%s, Ready=%s\n", (*(CD_alarm *)&D_801489B4).name,
                   comstr[CD_com], intstr[syncIdx], readyName);
            CD_flush();
            status = -1;
        } else {
            status = 0;
        }
        if (status != 0) {
            ret = -1;
            return ret;
        }
        if ((*D_8013C250 & 0x1000000) == 0) {
            ret = 0;
            goto done;
        }
    } while (mode == 0);
    ret = 1;
done:
    return ret;
}


extern int CD_getsector(void *madr, int size)
{
    (*D_8013C20C) = 0;
    (*D_8013C218) = 0x80;
    *D_8013C240 = 0x20943;
    *D_8013C21C = 0x1323;
    *D_8013C244 |= 0x8000;
    *D_8013C248 = (unsigned)madr;
    *D_8013C24C = size | 0x10000;
    while (((*D_8013C20C) & 0x40) == 0)
        ;
    *D_8013C250 = 0x11000000;
    while (*D_8013C250 & 0x1000000)
        ;
    *D_8013C21C = 0x1325;
    return 0;
}


extern int CD_getsector2(void *madr, int size)
{
    volatile int tmp;
    (*D_8013C20C) = 0;
    (*D_8013C218) = 0x80;
    *D_8013C240 = 0x21020843;
    *D_8013C21C = 0x1325;
    *D_8013C244 |= 0x8000;
    *D_8013C248 = (unsigned)madr;
    *D_8013C24C = size | 0x10000;
    while (((*D_8013C20C) & 0x40) == 0)
        ;
    *D_8013C250 = 0x11400100;
    tmp = *D_8013C250;
    return 0;
}




extern int D_8013C1F0;
extern void CD_set_test_parmnum(int n) { D_8013C1F0 = n; }




extern void _cd_intr_dispatch(void) { callback(); }
