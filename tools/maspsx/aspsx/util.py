from pathlib import Path

import subprocess
import shutil

ASPSX_RUNNER_LOOKUP = {
    # 16 bit
    "1.05": "dosemu2",
    "1.07": "dosemu2",
    "2.05": "dosemu2",
    "2.08": "dosemu2",
    "2.21": "dosemu2",
    "2.30": "dosemu2",
    "2.34": "dosemu2",
    # 32 bit
    "2.56": "wine",
    "2.67": "wine",
    "2.77": "wine",
    "2.79": "wine",
    "2.81": "wine",
    "2.86": "wine",
}

ASPSX_PSYQ_VERSION_LOOKUP = {
    "1.05": "1.05",
    "1.07": "1.07",
    "2.05": "2.05",
    "2.08": "2.08",
    "2.30": "2.30",
    "2.21": "psyq3.3",
    "2.34": "psyq3.5",
    "2.56": "psyq4.0",
    "2.67": "psyq4.1",
    "2.77": "psyq4.3",
    "2.79": "psyq4.4",
    "2.81": "psyq4.5",
    "2.86": "psyq4.6",
}


def read_text_section(data: bytes) -> bytes:
    # with thanks to https://github.com/grumpycoders/pcsx-redux/blob/main/tools/psyq-obj-parser/psyq-obj-parser.cc
    ptr = 0

    signature = data[ptr : ptr + 3]
    if signature != b"LNK":
        raise Exception("Not a psyq object!")
    ptr += 3

    version = data[ptr]
    if version != 2:
        raise Exception("Unknown version")
    ptr += 1

    sections = {}
    current_section = None

    while ptr < len(data):
        opcode = data[ptr]
        ptr += 1

        if opcode == 46:  # "PROGRAMTYPE"
            ptr += 1

        elif opcode == 16:  # "SECTION"
            section_index = int.from_bytes(data[ptr : ptr + 2], byteorder="little")
            ptr += 2

            # group = data[ptr:ptr + 2]
            ptr += 2

            # alignment = data[ptr]
            ptr += 1

            string_length = data[ptr]
            ptr += 1

            section_name = data[ptr : ptr + string_length]
            ptr += string_length

            sections[section_index] = section_name.decode("utf")

        elif opcode == 6:  # "SWITCH"
            section_index = int.from_bytes(data[ptr : ptr + 2], byteorder="little")
            ptr += 2
            current_section = sections[section_index]

        elif opcode == 2:  # "BYTES"
            size = int.from_bytes(data[ptr : ptr + 2], byteorder="little")
            ptr += 2

            payload = data[ptr : ptr + size]
            ptr += size

            if current_section == ".text":
                return payload

        elif opcode == 28:  #
            unknown = int.from_bytes(
                data[ptr : ptr + 2], byteorder="little"
            )  # always 9?
            ptr += 2

            strlen = data[ptr]
            ptr += 1

            filename = data[ptr : ptr + strlen].decode("utf")
            # print(f"filename: {filename}")

            ptr += strlen

        else:
            print(f"UNKNOWN OPCODE {opcode}")
            break

    raise Exception("Didn't find a .text section!")


def run_aspsx(source_asm: Path, version, data_limit="", extra_flags=""):
    aspsx_version = version["aspsx_version"]
    psyq_version = ASPSX_PSYQ_VERSION_LOOKUP[aspsx_version]

    psyq_base = Path(__file__).parent / Path(f"psyq/{psyq_version}")

    aspsx_path = psyq_base / "ASPSX.EXE"

    object_file = source_asm.with_suffix(".obj")
    object_file.unlink(missing_ok=True)

    # dosemu creates a lowercase file!
    object_file_name = psyq_base / object_file.name.lower()
    object_file_name.unlink(missing_ok=True)

    runner = ASPSX_RUNNER_LOOKUP[aspsx_version]

    if runner == "wine":
        cmd = [
            "wine",
            str(aspsx_path),
            data_limit,
            extra_flags,
            "-o",
            str(object_file),
            str(source_asm),
        ]
    elif runner == "dosemu2":
        shutil.copy(source_asm, psyq_base)
        cmd = [
            "dosemu",
            # "-quiet",
            "-dumb",
            "-K",
            f"{psyq_base}",
            "-E",
            f"ASPSX.EXE {data_limit} {extra_flags} -o {object_file.name} {source_asm.name}",
        ]

    print(f"Executing \"{' '.join(cmd)}\"")
    proc = subprocess.run(
        cmd,
        check=True,
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )

    if proc.returncode != 0:
        print(f"STDOUT: {proc.stdout.decode('utf')}")
        print(f"STDERR: {proc.stderr.decode('utf')}")
        raise Exception(
            f"Error running command: {' '.join(cmd)} for ASPSX {aspsx_version}."
        )

    if runner == "wine":
        if not object_file.exists():
            raise Exception(
                f"No PSYQ object created for: {' '.join(cmd)} for ASPSX {aspsx_version}"
            )
    elif runner == "dosemu2":
        # print(f"Copying {object_file_name} to {object_file}")
        if not object_file_name.exists():
            raise Exception(
                f"No PSYQ object created for: {' '.join(cmd)} for ASPSX {aspsx_version}"
            )
        shutil.move(object_file_name, object_file)

    text_data = read_text_section(object_file.read_bytes())
    if len(text_data) % 4 != 0:
        raise Exception(".text length is not aligned to 4 bytes")

    hex_data = "".join([f"{x:02X}"[::-1] for x in text_data])
    instructions = [
        "0x" + hex_data[i : i + 8][::-1] for i in range(0, len(hex_data), 8)
    ]
    return instructions
