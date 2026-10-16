"""Read-only GDB stack-allocation observer for a diagnostic GCC host.

Load using gdb -x tools/psyq_pipe/gcc_stack_probe.py -ex run --args HOST ...
Set NFS4_GCC_SYMBOL to the exact assembler name (default: LoadGame callback).
The host needs DWARF for function.c and must use the owning TU's real flags.

2026-10-15: adapted from the validated LoadGame slot-provenance diagnostic.
Never calls inferior functions, writes compiler variables, patches RTL, or
rewrites source/target output. Generated target instructions must independently
match native PsyQ before interpreting events. Reject callback exceptions,
abnormal exit, or zero matching events. The exit summary is coverage information,
not a byte/SYM/source certificate. This is a new tool; no prior file replaced.
"""
import json
import os
import gdb

TARGET = os.environ.get('NFS4_GCC_SYMBOL', 'MenuExtended_LoadGame__FR12tMenuCommand')
TREE_CODES = {f.enumval: f.name for f in gdb.lookup_type('enum tree_code').fields()}
event_count = 0


def value(expr):
    return gdb.parse_and_eval(expr)


def selected():
    decl = value('current_function_decl')
    if not decl:
        return False
    symbol = decl['decl']['assembler_name']
    return bool(symbol) and symbol['identifier']['pointer'].string() == TARGET


class SlotEnd(gdb.FinishBreakpoint):
    def __init__(self, row):
        super().__init__(gdb.newest_frame(), internal=True)
        self.row = row

    def stop(self):
        global event_count
        self.row['after'] = int(value('frame_offset'))
        event_count += 1
        print('GCC_STACK ' + json.dumps(self.row, sort_keys=True))
        return False


class Slot(gdb.Breakpoint):
    def stop(self):
        if not selected():
            return False
        row = dict(symbol=TARGET, before=int(value('frame_offset')),
                   size=int(value('size')), align=int(value('align')),
                   mode=str(value('mode')), callers=[])
        frame = gdb.newest_frame().older()
        for _ in range(5):
            if frame is None:
                break
            row['callers'].append(frame.name())
            if frame.name() == 'assign_temp':
                typ = frame.read_var('type')
                tag = typ['type']['name']
                if tag and TREE_CODES[int(tag['common']['code'])] == 'TYPE_DECL':
                    tag = tag['decl']['name']
                row['temporary'] = dict(
                    type=tag['identifier']['pointer'].string() if tag else None,
                    keep=int(frame.read_var('keep')),
                    memory_required=int(frame.read_var('memory_required')),
                    dont_promote=int(frame.read_var('dont_promote')))
            frame = frame.older()
        SlotEnd(row)
        return False


def exited(event):
    print('GCC_STACK_SUMMARY ' + json.dumps(dict(
        symbol=TARGET, events=event_count,
        exit_code=getattr(event, 'exit_code', None)), sort_keys=True))


gdb.execute('set pagination off')
Slot('assign_stack_local', internal=True)
gdb.events.exited.connect(exited)
