import io, subprocess, sys
P = 'recon/game/psx/device.cpp'
BASE = io.open(P, encoding='utf-8').read()
ORIG = """  if (min < max) {
    if (v < min) {
      v = 0;
    }
    else if (max < v) {
      v = 0xff;
    }
    else {
      v = ((v - min) * 0xff) / (max - min);
    }
  }
  else if (min != max) {
    if (v < max) {
      v = 0xff;
    }
    else if (min < v) {
      v = 0;
    }
    else {
      v = ((min - v) * 0xff) / (min - max);
    }
  }
  else {
    v = 0;
  }
  return v;"""
assert ORIG in BASE

V = {}
V['A_goto_shared_div'] = """  if (min < max) {
    if (v < min) {
      v = 0;
    }
    else if (max < v) {
      v = 0xff;
    }
    else {
      v = v - min;
      max = max - min;
      goto Device_Analog_divide;
    }
  }
  else if (min != max) {
    if (v < max) {
      v = 0xff;
    }
    else if (min < v) {
      v = 0;
    }
    else {
      v = min - v;
      max = min - max;
Device_Analog_divide:
      v = (v * 0xff) / max;
    }
  }
  else {
    v = 0;
  }
  return v;"""
V['B_split_sub'] = """  if (min < max) {
    if (v < min) {
      v = 0;
    }
    else if (max < v) {
      v = 0xff;
    }
    else {
      v = v - min;
      v = (v * 0xff) / (max - min);
    }
  }
  else if (min != max) {
    if (v < max) {
      v = 0xff;
    }
    else if (min < v) {
      v = 0;
    }
    else {
      v = min - v;
      v = (v * 0xff) / (min - max);
    }
  }
  else {
    v = 0;
  }
  return v;"""
V['C_earlyret'] = """  if (min < max) {
    if (v < min) return 0;
    if (max < v) return 0xff;
    v = ((v - min) * 0xff) / (max - min);
  }
  else if (min != max) {
    if (v < max) return 0xff;
    if (min < v) return 0;
    v = ((min - v) * 0xff) / (min - max);
  }
  else {
    v = 0;
  }
  return v;"""
for name, body in V.items():
    io.open(P, 'w', encoding='utf-8', newline='').write(BASE.replace(ORIG, body))
    r = subprocess.run([sys.executable, 'tools/verify_asm.py', P, 'Device_Analog__FUl'],
                       capture_output=True, text=True)
    line = [l for l in r.stdout.splitlines() if 'PASS' in l or 'FAIL' in l]
    print(name, line[:1] if line else (r.stdout[-300:] + r.stderr[-300:]))
io.open(P, 'w', encoding='utf-8', newline='').write(BASE)
