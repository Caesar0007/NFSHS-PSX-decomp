/* eaclib/psx/eacpsxz/systask.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 3/3 ***
 *   Source obj : nfs4\eaclib\psx\systask.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col12 / SYM v3)
 *   3 fns @[0x800E6AF4 .. 0x800E6C04].  A 16-slot periodic system-task scheduler driven by libticks.
 *   Ghidra nfs4-f.exe.c (systask) + IDA sigs.  Slot = 4 ints {fn, period, deadline, busy} (the Ghidra
 *   DAT_8013e984/988/98c are systemtasksubs+1/+2/+3, folded into the one array here).
 */

/* ---- owning-TU defs for link-harness (extern-declared, never defined; BSS) ---- */
 int gSysTaskCount; int gSysTaskLastTick; 
extern int libticks;          /* free-running tick counter */
extern int gSysTaskCount;     /* live task count */
extern int gSysTaskLastTick;  /* last tick the task list ran */
extern int systemtasksubs;    /* int[16*4] : 16 slots of {fn, period, deadline, busy} */

extern int          addsystemtask(void *taskFn, void *period, void *delay);  /* @0x800E6AF4 */
extern int          delsystemtask(int fn);                                   /* @0x800E6BA8 */
extern unsigned int systemtask(int arg1);                                    /* @0x800E6C04 */

/* addsystemtask @0x800E6AF4 : register a periodic task (or update its slot); returns the running count. */
extern int addsystemtask(void *taskFn, void *period, void *delay)
{
    int  tick  = libticks;
    int  i     = 0;
    int *slot  = &systemtasksubs;
    int  count = gSysTaskCount + 1;
    int  found = -1;
    int  sel;
    do {
        sel = i;
        if ((void *)*slot != taskFn &&
            (sel = found, (void *)*slot == (void *)0) &&
            found == -1 &&
            (sel = i, gSysTaskCount != 0)) {
            gSysTaskCount = gSysTaskCount - 1;
            sel = found;
        }
        i = i + 1;
        slot = slot + 4;
        found = sel;
    } while (i < 0x10);
    gSysTaskCount = count;
    if (sel != -1) {
        (&systemtasksubs)[sel * 4]     = (int)taskFn;
        (&systemtasksubs)[sel * 4 + 1] = (int)period;
        (&systemtasksubs)[sel * 4 + 3] = 0;
        (&systemtasksubs)[sel * 4 + 2] = tick + (int)delay;
    }
    gSysTaskCount = gSysTaskCount - 1;
    return gSysTaskCount;
}

/* delsystemtask @0x800E6BA8 : remove the task whose fn matches; returns the cleared fn (or end-marker). */
extern int delsystemtask(int fn)
{
    int  i    = 0;
    int *slot = &systemtasksubs;
    int  ret;
    do {
        if (*slot == fn)
            break;
        i = i + 1;
        slot = slot + 4;
    } while (i < 0x10);
    ret = i * 0x10;
    if (i < 0x10) {
        ret = (&systemtasksubs)[i * 4];
        if (ret == fn)
            (&systemtasksubs)[i * 4] = 0;
    }
    return ret;
}

/* systemtask @0x800E6C04 : once per tick, run every due task (fn(arg1, elapsed)) and re-arm it; OR of returns. */
extern unsigned int systemtask(int arg1)
{
    unsigned int result = 0;
    if (gSysTaskLastTick != libticks) {
        int  i    = 0;
        int *slot = &systemtasksubs;
        gSysTaskLastTick = libticks;
        do {
            if (*slot != 0 && slot[2] <= libticks && slot[3] == 0) {
                unsigned int r;
                int          t;
                slot[3] = 1;
                r = ((unsigned int (*)(int, int))*slot)(arg1, libticks - slot[2]);
                t = libticks;
                result |= r;
                slot[3] = 0;
                slot[2] = t + slot[1];
            }
            i = i + 1;
            slot = slot + 4;
        } while (i < 0x10);
    }
    return result;
}
