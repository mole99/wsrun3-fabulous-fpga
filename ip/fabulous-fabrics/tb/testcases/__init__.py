# SPDX-FileCopyrightText: © 2026 FABulous Contributors
# SPDX-License-Identifier: Apache-2.0

import os
import sys
from .common import tile_library, fabric

if tile_library == "classic":

    from .classic.all_ones import test_all_ones
    from .classic.all_zeros import test_all_zeros
    from .classic.passthrough import test_passthrough
    from .classic.addition import test_addition
    from .classic.counter import test_counter
    from .classic.multiplication import test_multiplication
    from .classic.sys_reset import test_sys_reset
    from .classic.ram_32x4_2r_1w import test_ram_32x4_2r_1w
    from .classic.register_file import test_register_file # why does it need to go last?

else:
    print(f"No test cases for tile library {tile_library}")
    sys.exit(0)
