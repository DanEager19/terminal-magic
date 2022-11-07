#!/usr/bin/env python3

import r2pipe
import json
import re

class FunctionExam:
    def __init__ (self):
        self.r2 = r2pipe.open("./OpenBTS.bin")
        self.r2.cmd("aaaa")
        self.functions = self.r2.cmd("aflj")
        self.jsonfunctions = json.loads(self.functions)

    def find_functions(self):
        dangerousfunctions = [
            "\.strcpy",
            "\.strcat",
            "\.strncpy",
            "\.strncat",
            "\.sprintf", 
            "\.vsprintf", 
            "\.scanf", 
            "\.sscanf", 
            "\.gets ", 
            "\.atoi", 
            "\.atof", 
            "\.atol", 
            "\.execve", 
            "\.system", 
            "\.popen"
        ]
        print("[~] - Finding dangerous functions...")
        for jsonfunc in self.jsonfunctions:
            for danger in dangerousfunctions:
                if(re.search(danger, jsonfunc["name"]) != None):
                    print("[~] - Call for {}".format(jsonfunc["name"]))
                    for call in jsonfunc["codexrefs"]:
                        addr = hex(call["addr"])
                        funccall = self.r2.cmd("afd {}".format(addr)).split(' ')
                        self.r2.cmd("s {}".format(hex(call["addr"])))
                        print("\t[~] - Called @ {} by {}".format(addr, funccall[0]))
        print("[~] - Done!")

f1 = FunctionExam()
f1.find_functions()
