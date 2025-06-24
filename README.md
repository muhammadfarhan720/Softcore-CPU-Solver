# Softcore-CPU-Solver
Hardware–software co‑design: a NIOS II soft‑core CPU (PS) running bare metal‑C programming to compute McLaurin series, with a Verilog FSM (PL) for managing on‑chip RAM transfers on FPGA fabric.


## System Components

| Component            | Function               | Specifications               |
|----------------------|------------------------|-------------------------------|
| **Nios II Processor** | Series computation     | 24KB RAM, Custom PIOs         |
| **Control FSM**      | Data coordination      | 5-state machine               |
| **Result Memory**    | Output storage         | 16×32-bit array               |
| **Peripheral Interface** | Visualization      | Hex displays + LEDs           |
