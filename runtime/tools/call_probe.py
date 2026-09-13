#!/usr/bin/env python3
"""call_probe.py -- direct-call a function in the live game and compare state.

Hijack-call-restore: from a checkpoint, save the full register context, plant
a trap (`break`) at a scratch address, set $a0..$a3/$pc/$ra, run to the trap
(the call completes synchronously up to its return), capture $v0/$v1, restore
the saved context, then run N driven frames so any queued async work pumps to
completion, and dump RAM.  Run once per variant (baseline / --patch candidate)
and ramdiff the dumps.

Usage:
  py -3.14 runtime/tools/call_probe.py --checkpoint frontend-loaded-v1 \
      --fn 0x800FBFDC --args 0 --frames 300 --out traces/format-base.ram \
      [--patch-file status/probe-X.patch]
"""
import argparse, json, sys, time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from gdb_remote import Remote

RUNTIME = Path(__file__).resolve().parents[1]
PORT = 2350
PAD_UPDATE = 0x800E4210
RAW_PAD0 = 0x8013E8F0
TRAP_VA = 0x801E5F00          # scratch word for the return trap

def stop_cpu(g):
    for _ in range(3):
        try:
            r = g.packet('?', timeout=2)
            if r.startswith(('S', 'T')):
                g.stopped = True
                return
        except (TimeoutError, OSError):
            pass
        try:
            r = g.interrupt()
            if r.startswith(('S', 'T')):
                g.stopped = True
                return
        except (TimeoutError, OSError):
            pass
    raise RuntimeError('cannot stop CPU')

def set_reg(regs_hex, idx, value):
    b = bytearray(regs_hex, 'ascii')
    b[idx*8:idx*8+8] = value.to_bytes(4, 'little').hex().encode()
    return b.decode()

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--checkpoint', required=True)
    ap.add_argument('--fn', required=True, type=lambda s: int(s, 16))
    ap.add_argument('--args', default='', help='comma ints/hex for a0..a3')
    ap.add_argument('--frames', type=int, default=300)
    ap.add_argument('--out', required=True)
    ap.add_argument('--patch-file')
    ap.add_argument('--at', type=lambda s: int(s, 16), default=0x8001373C,
                    help='deterministic MAIN-THREAD hijack point (default: '
                         'Redraw__14tFEApplication) -- the checkpoint itself '
                         'rests inside the VSync/timer ISR, where a blocking '
                         'callee could deadlock')
    args = ap.parse_args()
    g = Remote('127.0.0.1', PORT)
    try:
        stop_cpu(g)
        g.checkpoint(args.checkpoint, load=True)
        if args.patch_file:
            spec = json.loads((RUNTIME / args.patch_file).read_text())['patch']
            for p in spec.split(','):
                va, hexb = p.split('=')
                assert g.packet(f'M{int(va,16):x},{len(hexb)//2:x}:{hexb}') == 'OK'
        if args.at:
            assert g.packet(f'Z0,{args.at:x},4') == 'OK'
            g.send_no_reply('c')
            while True:
                r = g._receive_packet()
                if r.startswith(('S', 'T')):
                    g.stopped = True
                    break
            g.packet(f'z0,{args.at:x},4')
        saved = g.packet('g')
        # trap: break 0 at TRAP_VA (plus a nop delay-mate)
        assert g.packet(f'M{TRAP_VA:x},8:0d000000' + '00000000') == 'OK'
        regs = saved
        avals = [int(x, 0) for x in args.args.split(',') if x != '']
        for i, v in enumerate(avals[:4]):
            regs = set_reg(regs, 4 + i, v)
        regs = set_reg(regs, 31, TRAP_VA)          # $ra
        regs = set_reg(regs, 37, args.fn)          # pc
        assert g.packet('G' + regs) == 'OK'
        assert g.packet(f'Z0,{TRAP_VA:x},4') == 'OK'
        g.send_no_reply('c')
        deadline = time.time() + 120        # a blocking callee (e.g. a real
        while True:                         # card format) spans many frames
            try:
                r = g._receive_packet()
            except TimeoutError:
                if time.time() > deadline:
                    raise RuntimeError('callee never returned to the trap')
                continue
            if r.startswith(('S', 'T')):
                g.stopped = True
                break
        after = g.packet('g')
        pc = int.from_bytes(bytes.fromhex(after[37*8:37*8+8]), 'little')
        v0 = int.from_bytes(bytes.fromhex(after[2*8:2*8+8]), 'little')
        v1 = int.from_bytes(bytes.fromhex(after[3*8:3*8+8]), 'little')
        assert pc == TRAP_VA, f'stopped at {pc:#x}, not the trap'
        print(f'call returned: v0={v0:#x} v1={v1:#x}')
        g.packet(f'z0,{TRAP_VA:x},4')
        assert g.packet('G' + saved) == 'OK'       # restore interrupted context
        # pump N frames with neutral injected input
        assert g.packet(f'Z0,{PAD_UPDATE:x},4') == 'OK'
        for _ in range(args.frames):
            g.send_no_reply('c')
            while True:
                r = g._receive_packet()
                if r.startswith(('S', 'T')):
                    g.stopped = True
                    break
            g.packet(f'M{RAW_PAD0:x},4:0041ffff')
        ram = g.read_memory(0x80000000, 0x200000)
        out = RUNTIME / args.out
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_bytes(ram)
        (out.with_suffix(out.suffix + '.result')).write_text(
            json.dumps({'v0': hex(v0), 'v1': hex(v1), 'frames': args.frames}))
        import hashlib
        print(f'{args.frames} frames -> {out}  sha256 '
              f'{hashlib.sha256(ram).hexdigest()[:16]}')
        g.packet(f'z0,{PAD_UPDATE:x},4')
    finally:
        try:
            stop_cpu(g)
            g.packet(f'z0,{PAD_UPDATE:x},4', timeout=2)
            g.packet(f'z0,{TRAP_VA:x},4', timeout=2)
        except Exception:
            pass
        g.close()

if __name__ == '__main__':
    main()
