# Topmetal-S sensor tiled plane

## PCB

One should use pcbnew manually to setup a PCB `template' with appropriate layer structure, via and track classes etc., then run the Python script that references the template.

It is important to generate a sch containing all needed netnames.  Then generate a netlist which is then imported into the template PCB.

### Unit cell
Phi10cmBonding/TMS1mm1chip

## Software
### KiCad

Pull source from https://github.com/KiCad/kicad-source-mirror and compile.

### KiCadScript in Hardware/PCB/KiCadScript/

#### Compile C source code to be used in python
```sh
cd KiAuto/hexlib/
python setup.py build
cd build
ln -s lib.freebsd-11.0-STABLE-amd64-2.7/hexlib.so .
```

# PCB design and manufacturing

## Manufacturer capabilities

[Sunstone capabilityes](http://www.sunstone.com/pcb-manufacturing-capabilities/detailed-capabilities)

|                     | Sunstone preferred | Sunstone capable |
| ------------------- |:------------------ |:---------------- |
| minimum drill size  | 0.008"             | 0.005"           |
| minimum trace width | 0.004" 1 oz Cu     | 0.003"           |
| trace clearance     | 0.004" 1 oz Cu     | 0.003"           |
| through-hole pad dia | 0.018" larger than finished hole dia | 0.016" larger |

Finished hole dia = drill dia - 4mil

### Typical board thickness in inch
```
0.062, 0.093, 0.125
```

### Typical drill sizes diameter in inch
```
0.008, 0.014, 0.020, 0.025, 0.029, 0.033, 0.035, 0.040, 0.043, 0.046, 0.052, 0.061,
0.067, 0.079, 0.088, 0.093, 0.100, 0.110, 0.125, 0.141, 0.150, 0.167, 0.192, 0.251
```
### Via
A recommendation: make the drill size diameter the same as the width of the trace, and the pad size roughly twice the diameter.
