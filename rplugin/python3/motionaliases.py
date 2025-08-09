from dataclasses import dataclass
import logging
from pathlib import Path
from types import NoneType
from typing import NamedTuple, cast
from time import sleep

import pynvim
from pynvim import attach

logging.basicConfig(filename="/home/frank/plugoutput.txt", filemode='w', level=logging.CRITICAL)
logger = logging.getLogger(__name__)

@dataclass
class AliasMapping:
    alias: str
    keys: list[str]


class CursorPosition(NamedTuple):
    row: int
    col: int

type SurroundPositions = tuple[CursorPosition, CursorPosition]

@pynvim.plugin
class MotionAliases:
    def __init__(self, vim: pynvim.Nvim) -> None:
        self.__vim = attach('socket', path = vim.funcs.expand('%'))
        logger.critical(type(self.__vim))

        self.__config = self.parse_config(Path(""))

    def parse_config(self, config_file: Path) -> list[AliasMapping]:
        return [AliasMapping("aq", ['a"', "a'", "a`"])]

    def echo(self, msg: str) -> None:
        self.__vim.command(f"echo \"{msg}\"")

    @pynvim.command(name="QuoteMotion", sync=True)
    def testcommand(self):
        conf = self.__config
        closest = cast(str, self.resolve_closest_motion(*conf[0].keys))

        # # self.echo(closest)
        # with open("/home/frank/plugoutput.txt", 'w') as f:
        #     f.write(closest)


    @pynvim.function("myfunc_1", sync=True)
    def setaliasmapping(self, mapping: AliasMapping) -> None:
        self.__vim.call("vmap", ":QuoteMotion a")

    @pynvim.function("myfunc_2", sync=True)
    def resolve_closest_motion(self, *keys: str) -> None:
        logging.critical(f"Resolving motions: {keys}...")
        initial_pos = self.get_cursor_position()
        logging.critical(f"Initial position: {initial_pos}")
        positions = {key: self.probe_surrounding_motion(initial_pos, key) for key in keys}

        logging.critical(f"Other_positions: {positions}")
        closest = self.get_closest(initial_pos, positions)

        return cast(NoneType, closest)

    @pynvim.function("myfunc_3", sync=True)
    def probe_surrounding_motion(self, initial_pos: CursorPosition, key: str) -> SurroundPositions:
        initial = self.__vim.api.win_get_cursor(0)
        self.__vim.feedkeys(self.__vim.replace_termcodes(f"v{key}"))
        pos1 = self.__vim.api.win_get_cursor(0)
        self.__vim.feedkeys(self.__vim.replace_termcodes("o<esc>"))
        pos2 = self.__vim.api.win_get_cursor(0)
        self.__vim.feedkeys(f"{initial[0]}G{initial[1]+1}|")

        lpos = CursorPosition(*pos1)
        rpos = CursorPosition(*pos2)
        logger.critical(lpos)
        logger.critical(rpos)
        return lpos, rpos

    @pynvim.function("myfunc_4", sync=True)
    def get_cursor_position(self) -> CursorPosition:
        self.__vim.api.win_get_cursor(0)
        row, col = self.__vim.api.win_get_cursor(0)

        return CursorPosition(row=row, col=col)

    @pynvim.function("myfunc_5", sync=True)
    def blocking_feedkeys(self, s: str) -> None:
        input = self.__vim.replace_termcodes(s, True, True, True)
        logger.critical(f"Feeding keys: {input}")
        self.__vim.feedkeys(input, 'm', False)
        self.__vim.eval("1")

    @pynvim.function("myfunc_6", sync=True)
    def perform_surrounding_motion(self, key: str) -> SurroundPositions:
        self.blocking_feedkeys(f"{'<esc>' * 3}")
        self.blocking_feedkeys(f"v{key}{'<esc>'*3}iH<esc>")
        pos1 = self.get_cursor_position()
        self.blocking_feedkeys(f"v{key}o{'<esc>'*3}aH<esc>")
        pos2 = self.get_cursor_position()

        self.blocking_feedkeys(f"{'<esc>' * 3}")
        return pos1, pos2

    @pynvim.function("myfunc_7", sync=True)
    def go_to_position(self, pos: CursorPosition) -> None:
        self.__vim.api.win_set_cursor(0, (pos.row, pos.col))
        self.__vim.feedkeys(f"{pos.row}G{pos.col}|")

    @pynvim.function("myfunc_8", sync=True)
    def get_closest(self, initial_pos: CursorPosition, surround_positions: dict[str, SurroundPositions]) -> str:
        distances = {k: self.compute_min_distance(initial_pos, *v) for k, v in surround_positions.items()}

        return sorted(distances.keys(), key = lambda k: distances[k])[0]
        
    @pynvim.function("myfunc_9", sync=True)
    def compute_min_distance(self, initial_pos: CursorPosition, *positions: CursorPosition) -> int:
        return min(*(self.compute_distance(initial_pos, pos) for pos in positions))

    @pynvim.function("myfunc_10", sync=True)
    def compute_distance(self, pos1: CursorPosition, pos2: CursorPosition) -> int:
        linewidth = 80
        return abs(pos1.col - pos2.col) * linewidth + abs(pos1.row - pos2.row)


# 'aaaaaaaaaaaaaaaaaaaaaaaaaa'
# H"HbbbbbbbbbbbbbbbbbbbbbbbbbbHH"
# `cccccccccccccccccccccccccc`
