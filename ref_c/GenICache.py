import os
import pandas as pd
from Env import *


class GenICache(Env)    : 
    def __init__(self)  : 
        self.opcode_set = set(
            {'R_FORMAT' , 0b0110011},
            {'I_FORMAT' , 0b0010011},
            {'I2_FORMAT', 0b0000011},
            {'S_FORMAT' , 0b0100011},
            {'SB_FORMAT', 0b1001011},
            {'U_FORMAT' , 0b1100111},
            {'J_FORMAT' , 0b1101111},
        )
        
        pass



if __name__ == '__main__':
    pass