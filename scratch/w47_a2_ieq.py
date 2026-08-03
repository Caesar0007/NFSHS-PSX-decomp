FN = 'iSPCH_InitEventQueue'

PRELUDE = r'''
extern int            gVoxEvents[];
extern unsigned char  gVoxEventQueue[] __asm__("gVoxEvents");
extern int            gLastTick[];
extern short          gLastSubTick[];
'''

_LOOP = r'''
    do {
        int j = 0;
        int off = argBase;
        *(volatile short *)(slot + 8)  = 0;
        *(volatile short *)(slot + 0xa) = 0;
        *(volatile int *)(slot + 0xc)  = 0;
        *(volatile int *)(slot + 0x10) = 0;
      inner:
        *(int *)(off + base + 0x14) = 0;
        j = j + 1;
        off = off + 4;
        if (j < 0xc)
            goto inner;
        slot = slot + 0x3c;
        argBase = argBase + 0x3c;
    } while (slot < end);
    gLastTick[0]    = 0;
    gLastSubTick[0] = 0;
}
'''


def V(head):
    return 'void iSPCH_InitEventQueue(void)\n{\n' + head + _LOOP


VARIANTS = {
    'base(two views)': V('''    int argBase = 0;
    int base = (int)gVoxEvents;
    int slot = (int)gVoxEventQueue;
    int end  = base + 0x3c0;
    gVoxEvents[0]   = 0;
    *(int *)(base + 4) = 0;
'''),
    'chain_addr_base_slot': V('''    int argBase = 0;
    int addr = (int)gVoxEvents;
    int base = addr;
    int slot = base;
    int end  = base + 0x3c0;
    gVoxEvents[0]   = 0;
    *(int *)(base + 4) = 0;
'''),
    'chain_end_from_slot': V('''    int argBase = 0;
    int addr = (int)gVoxEvents;
    int base = addr;
    int slot = base;
    int end  = slot + 0x3c0;
    gVoxEvents[0]   = 0;
    *(int *)(base + 4) = 0;
'''),
    'chain_view_addr': V('''    int argBase = 0;
    int addr = (int)gVoxEventQueue;
    int base = addr;
    int slot = base;
    int end  = base + 0x3c0;
    gVoxEvents[0]   = 0;
    *(int *)(base + 4) = 0;
'''),
    'chain_store_via_addr': V('''    int argBase = 0;
    int addr = (int)gVoxEvents;
    int base = addr;
    int slot = base;
    int end  = base + 0x3c0;
    *(int *)addr    = 0;
    *(int *)(base + 4) = 0;
'''),
    'chain_slot_from_view': V('''    int argBase = 0;
    int base = (int)gVoxEvents;
    int slot = base;
    int end  = base + 0x3c0;
    gVoxEvents[0]   = 0;
    *(int *)(base + 4) = 0;
'''),
    'chain4': V('''    int argBase = 0;
    int addr = (int)gVoxEvents;
    int base = addr;
    int slot = base;
    int end  = slot + 0x3c0;
    *(int *)addr    = 0;
    *(int *)(base + 4) = 0;
'''),
}
