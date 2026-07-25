import sys, importlib.util, difflib
fn = sys.argv[1]
sys.argv = ['verify_asm.py', 'recon/game/common/camera.cpp', fn]
spec = importlib.util.spec_from_file_location('va', 'tools/verify_asm.py')
va = importlib.util.module_from_spec(spec)
spec.loader.exec_module(va)
