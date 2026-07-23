# Thin wrapper over tools/build.py (the canonical, cross-platform driver).
# Requires Python 3.12 (splat's rabbitizer/spimdisasm wheels live there).
PY ?= py -3.12
SPLAT ?= C:/Temp/splat-main/split.py

.PHONY: all audit skipasm split symbols clean
all:
	$(PY) tools/build.py

audit:
	$(PY) tools/audit_vtable_indexing.py

skipasm:
	$(PY) tools/build.py --skip-asm

symbols:
	$(PY) tools/gen_symbols.py

split: symbols
	$(PY) $(SPLAT) configs/nfs4.yaml
	$(PY) tools/fix_gte.py

clean:
	$(PY) tools/build.py clean
