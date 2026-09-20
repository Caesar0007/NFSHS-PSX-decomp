"""Shim: the tools in this folder run with tools/psyq_pipe as their script directory; the real module is tools/retail_sym.py."""
import importlib.util
from pathlib import Path

_spec = importlib.util.spec_from_file_location('_retail_sym', str(Path(__file__).resolve().parents[1] / 'retail_sym.py'))
_mod = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_mod)
txt = _mod.txt
dumpsym = _mod.dumpsym
