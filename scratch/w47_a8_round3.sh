set -e
R3="-fno-omit-frame-pointer,-fpack-struct,-funsigned-bitfields,-membedded-data,-ftraditional,-fno-keep-static-consts,-mno-memcpy,-funroll-loops|-funroll-max=1,-funroll-loops|-funroll-max=2,-mdebuga,-mdebugc,-mdebugd,-mdebugf"
for j in scratch/base_*.json; do
  stem=$(basename $j .json); stem=${stem#base_}
  tu=$(python -c "import json,glob;
import sys
for f in glob.glob('scratch/sweep_$stem.json'):
    print(json.load(open(f))['tu'])" 2>/dev/null)
  [ -z "$tu" ] && continue
  echo "### $tu"
  python scratch/w47_a8_sweep.py "$tu" --only "$R3" --out scratch/sweep3_$stem.json 2>&1 | grep -E '^\*\*\*|BUILDFAIL|^BASE'
done
