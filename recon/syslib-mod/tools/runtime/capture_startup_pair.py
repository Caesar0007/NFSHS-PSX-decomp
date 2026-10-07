#!/usr/bin/env python3
"""Cold-boot a retail/candidate NFS4 pair to GameModuleStartUp and compare exposed state."""
import argparse, hashlib, json, os, struct, sys, threading, time, uuid
from pathlib import Path

PAIR = Path(r'C:\Temp\nfs4-syslib-pair')
RT_TOOLS = Path(r'C:\Temp\nfs4-runtime')
sys.path.insert(0, str(RT_TOOLS))
os.environ.setdefault('FF_GDB_RAM_BACKEND', 'auto')
from gdb_remote import Remote, decode_registers

PAD_RET, STARTUP, PAD_STATE = 0x800E4310, 0x800A41A8, 0x8013E8A2
CROSS, START = 0x4000, 0x0008
FORBIDDEN_NAMES = {0x800F6D18:'FntFlush'}
FORBIDDEN = tuple(FORBIDDEN_NAMES)
WATCHED_NAMES = {0x80106BE4:'PCread', 0x80106CA4:'PCopen', 0x80106CC4:'PCinit',
                 0x80106CD0:'PCcreat', 0x80106D1C:'PClseek', 0x80106D40:'PCclose',
                 0x80106D50:'PCwrite'}
WATCHED = tuple(WATCHED_NAMES)

def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()

def validate_record(path):
    record = json.loads(path.read_text(encoding='utf-8-sig'))
    checks = {'runtime_sha256':'executable','settings_sha256':'settings','bios_sha256':'bios',
              'cue_sha256':'cue','image_sha256':'image'}
    for expected, item in checks.items():
        if sha(record[item]) != record[expected]:
            raise ValueError(f'{record["role"]} identity changed: {item}')
    return record

def reg(remote, number):
    return int.from_bytes(bytes.fromhex(remote.packet(f'p{number:x}')), 'little')

def wait_stop(remote, timeout):
    remote.s.settimeout(timeout)
    try:
        while True:
            packet = remote._receive_packet()
            if packet[:1] in ('T','S'):
                return packet
    finally:
        remote.s.settimeout(3)

def pad(frame):
    cycle, phase = divmod(frame, 24)
    if phase < 4:
        return 0xffff & ~(START if cycle % 4 == 3 else CROSS)
    return 0xffff

def worker(record, record_path, output, result, index, abort):
    remote = Remote('127.0.0.1', record['port'])
    origin = f'nfs4-syslib-origin-{uuid.uuid4().hex[:12]}'
    try:
        remote.packet('qSupported')
        remote.checkpoint(origin)
        for bp in (PAD_RET, STARTUP, *FORBIDDEN, *WATCHED):
            if remote.packet(f'Z0,{bp:x},4') != 'OK':
                raise RuntimeError(f'breakpoint rejected {bp:#x}')
        frame = 0
        watched = {name:0 for name in WATCHED_NAMES.values()}
        while frame < 20000:
            remote.send_no_reply('c'); wait_stop(remote, 90)
            pc = reg(remote, 37)
            if abort.is_set():
                raise RuntimeError('peer runtime aborted')
            if pc == STARTUP:
                break
            if pc in FORBIDDEN:
                raise RuntimeError(f'forbidden entry executed: {FORBIDDEN_NAMES[pc]} at {pc:#x}')
            if pc in WATCHED:
                watched[WATCHED_NAMES[pc]] += 1
                remote.packet(f'z0,{pc:x},4')
                remote.packet('s', timeout=10)
                remote.packet(f'Z0,{pc:x},4')
                continue
            if pc != PAD_RET:
                raise RuntimeError(f'unexpected stop {pc:#x}')
            frame += 1
            raw = struct.pack('<H', pad(frame)).hex()
            if remote.packet(f'M{PAD_STATE:x},2:{raw}') != 'OK':
                raise RuntimeError('pad write rejected')
            if frame % 1000 == 0:
                print(record['role'], 'frame', frame, flush=True)
        if pc != STARTUP:
            raise RuntimeError('startup boundary not reached')
        for bp in (PAD_RET, STARTUP, *FORBIDDEN, *WATCHED):
            remote.packet(f'z0,{bp:x},4')
        registers = remote.packet('g')
        ram = remote.read_memory(0x80000000, 0x200000)
        scratch = remote.read_memory(0x1f800000, 0x400)
        checkpoint = f'nfs4-syslib-startup-{record["role"]}-{uuid.uuid4().hex[:12]}'
        remote.checkpoint(checkpoint)
        (output / f'{record["role"]}-ram.bin').write_bytes(ram)
        (output / f'{record["role"]}-scratch.bin').write_bytes(scratch)
        result[index] = dict(role=record['role'], frames=frame, watched_entries=watched, registers=registers,
                             ram=ram, scratch=scratch, checkpoint=checkpoint, origin=origin,
                             record_path=str(record_path), record_sha256=sha(record_path))
    except Exception as exc:
        abort.set()
        try: remote.interrupt()
        except Exception: pass
        try: remote.checkpoint(origin, load=True)
        except Exception: pass
        result[index] = dict(role=record['role'], error=repr(exc), origin=origin)
    finally:
        remote.close()

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--image-report', type=Path)
    args = parser.parse_args(); output = args.output.resolve()
    if output.exists(): parser.error('output must not already exist')
    output.mkdir(parents=True)
    paths = [PAIR/'retail-process.json', PAIR/'candidate-process.json']
    records = [validate_record(path) for path in paths]
    if records[0]['port'] == records[1]['port'] or records[0]['pid'] == records[1]['pid']:
        raise ValueError('pair is not isolated')
    rows = [None, None]
    abort = threading.Event()
    threads = [threading.Thread(target=worker, args=(records[i],paths[i],output,rows,i,abort), daemon=True)
               for i in range(2)]
    for thread in threads: thread.start()
    for thread in threads: thread.join()
    image_report = None
    if args.image_report:
        image_report = json.loads(args.image_report.read_text(encoding='utf-8'))
        if image_report['image_sha256'] != records[1]['image_sha256']:
            raise ValueError('candidate process is not running the reported image')
        symmetric_image = records[0]['image_sha256'] == records[1]['image_sha256']
        if symmetric_image and image_report['image_sha256'] != records[0]['image_sha256']:
            raise ValueError('symmetric control is not running the reported image')
    else:
        symmetric_image = False
    report = dict(schema='nfs4-syslib-startup-pair-v1', passed=False,
                  boundary=f'{STARTUP:08X}', records=[], comparison={},
                  image_report=None if not args.image_report else str(args.image_report),
                  image_report_sha256=None if not args.image_report else sha(args.image_report))
    if any('error' in row for row in rows):
        report['records'] = [{k:v for k,v in row.items() if k not in ('ram','scratch','registers')}
                             for row in rows]
    else:
        decoded = [decode_registers(row['registers']) for row in rows]
        compared_ram = [rows[0]['ram'], rows[1]['ram']]
        if image_report and not symmetric_image:
            retail_exe = Path(image_report['source_exe']).read_bytes()
            load = int(image_report['load'],16)
            normalized = bytearray(compared_ram[1])
            for hexva,size in image_report['code_ranges']:
                va = int(hexva,16); source = 0x800 + va - load; dest = va & 0x1fffff
                normalized[dest:dest+size] = retail_exe[source:source+size]
            for hexva,size in image_report.get('runtime_normalize_ranges',[]):
                va=int(hexva,16);dest=va&0x1fffff;normalized[dest:dest+size]=compared_ram[0][dest:dest+size]
            compared_ram[1] = bytes(normalized)
        stack = min(int(row['r29'],16) for row in decoded)
        differences = []
        for offset in range(0,0x200000,4):
            left,right = compared_ram[0][offset:offset+4],compared_ram[1][offset:offset+4]
            if left == right: continue
            va = 0x80000000 + offset
            kind = ('kernel-timing' if va < 0x80010000 else
                    'interrupt-stack-residue' if 0x80134B60 <= va < 0x80135B60 else
                    'dead-stack-below-sp' if stack-0x1000 <= va < stack else 'game-state')
            differences.append(dict(va=f'{va:08X}',retail=left.hex(),candidate=right.hex(),kind=kind))
        regdiff = {key:[decoded[0][key],decoded[1][key]] for key in decoded[0]
                   if decoded[0][key] != decoded[1][key]}
        ignored_regs = {'r26','r27','cause','epc','badvaddr'}
        game = [row for row in differences if row['kind']=='game-state']
        report['records'] = [{k:v for k,v in row.items() if k not in ('ram','scratch','registers')}
                             for row in rows]
        report['comparison'] = dict(frame_counts=[row['frames'] for row in rows],
            symmetric_image=symmetric_image,
            game_state_differences=len(game), kernel_timing_differences=sum(x['kind']=='kernel-timing' for x in differences),
            interrupt_stack_differences=sum(x['kind']=='interrupt-stack-residue' for x in differences),
            dead_stack_differences=sum(x['kind']=='dead-stack-below-sp' for x in differences),
            first_differences=differences[:80], register_differences=regdiff,
            scratchpad_equal=rows[0]['scratch']==rows[1]['scratch'],
            live_registers_equal=not [k for k in regdiff if k not in ignored_regs])
        report['passed'] = (not game and report['comparison']['scratchpad_equal'] and
                            report['comparison']['live_registers_equal'] and decoded[0]['pc']==decoded[1]['pc'])
    (output/'report.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({k:report.get(k) for k in ('passed','boundary','comparison')},indent=2))
    return 0 if report['passed'] else 1

if __name__ == '__main__': raise SystemExit(main())
