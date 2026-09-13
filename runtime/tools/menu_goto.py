#!/usr/bin/env python3
"""menu_goto.py -- jump the frontend to a named screen via SetMenu.

Scans the tFEApplication menu table (FEApp+4+id*4) live for the entry whose
object's vtable matches the target class, then hijack-calls
SetMenu(FEApp, id, menu) at a main-thread anchor and pumps N frames.

Usage:
  py -3.14 runtime/tools/menu_goto.py --class 14tScreenMemcard --frames 240 \
      [--checkpoint settled-v1] [--save memcard-screen-v1]
"""
import argparse, re, sys, time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from gdb_remote import Remote

ROOT = Path(__file__).resolve().parents[2]
PORT = 2350
FEAPP = 0x800514C0
SETMENU = 0x80013E20
VSYNC = 0x800F231C
PAD_UPDATE = 0x800E4210
RAW_PAD0 = 0x8013E8F0
TRAP_VA = 0x801E5F00

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

def vt_addr(cls):
    pat = re.compile(r'^\s*_vt[._]' + re.escape(cls) + r'\s*=\s*(0x[0-9A-Fa-f]+)\s*;')
    for ln in (ROOT / 'configs' / 'symbol_addrs.txt').read_text().splitlines():
        m = pat.match(ln)
        if m:
            return int(m.group(1), 16)
    return None

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--class', dest='cls', required=True)
    ap.add_argument('--frames', type=int, default=240)
    ap.add_argument('--checkpoint')
    ap.add_argument('--save')
    args = ap.parse_args()
    vt = vt_addr(args.cls)
    assert vt, f'no _vt symbol for {args.cls} in symbol_addrs'
    print(f'{args.cls} vtable: 0x{vt:08X}')
    g = Remote('127.0.0.1', PORT)
    try:
        stop_cpu(g)
        if args.checkpoint:
            g.checkpoint(args.checkpoint, load=True)
        # main-thread anchor
        assert g.packet(f'Z0,{VSYNC:x},4') == 'OK'
        g.send_no_reply('c')
        while True:
            r = g._receive_packet()
            if r.startswith(('S', 'T')):
                g.stopped = True
                break
        g.packet(f'z0,{VSYNC:x},4')
        # scan the menu table
        table = g.read_memory(FEAPP + 4, 64 * 4)
        target_id = menu_ptr = None
        for i in range(64):
            p = int.from_bytes(table[i*4:i*4+4], 'little')
            if 0x80010000 <= p < 0x80200000:
                vtw = int.from_bytes(g.read_memory(p, 4), 'little')
                if vtw == vt:
                    target_id, menu_ptr = i, p
                    break
        assert target_id is not None, 'target class not found in the menu table'
        print(f'menu id {target_id}, object 0x{menu_ptr:08X}')
        saved = g.packet('g')
        assert g.packet(f'M{TRAP_VA:x},8:0d00000000000000') == 'OK'
        regs = set_reg(saved, 4, FEAPP)
        regs = set_reg(regs, 5, target_id)
        regs = set_reg(regs, 6, menu_ptr)
        regs = set_reg(regs, 31, TRAP_VA)
        regs = set_reg(regs, 37, SETMENU)
        assert g.packet('G' + regs) == 'OK'
        assert g.packet(f'Z0,{TRAP_VA:x},4') == 'OK'
        g.send_no_reply('c')
        while True:
            try:
                r = g._receive_packet()
            except TimeoutError:
                raise RuntimeError('SetMenu never returned')
            if r.startswith(('S', 'T')):
                g.stopped = True
                break
        g.packet(f'z0,{TRAP_VA:x},4')
        print('SetMenu returned')
        assert g.packet('G' + saved) == 'OK'
        # pump frames so the screen initializes with the game's own machinery
        assert g.packet(f'Z0,{PAD_UPDATE:x},4') == 'OK'
        for _ in range(args.frames):
            g.send_no_reply('c')
            while True:
                r = g._receive_packet()
                if r.startswith(('S', 'T')):
                    g.stopped = True
                    break
            g.packet(f'M{RAW_PAD0:x},4:0041ffff')
        g.packet(f'z0,{PAD_UPDATE:x},4')
        if args.save:
            g.checkpoint(args.save)
            print(f'checkpoint {args.save} saved')
    finally:
        try:
            stop_cpu(g)
            g.packet(f'z0,{PAD_UPDATE:x},4', timeout=2)
            g.send_no_reply('c')
        except Exception:
            pass
        g.close()

if __name__ == '__main__':
    main()
