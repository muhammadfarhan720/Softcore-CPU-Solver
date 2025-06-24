# Softcore-CPU-Solver
Hardware–software co‑design: a NIOS II soft‑core CPU (PS) running bare metal‑C programming to compute McLaurin series, with a Verilog FSM (PL) for managing on‑chip RAM transfers on FPGA fabric.


## System Components

| Component            | Function               | Specifications               |
|----------------------|------------------------|-------------------------------|
| **Nios II Processor** | Series computation     | 24KB RAM, Custom PIOs         |
| **Control FSM**      | Data coordination      | 5-state machine               |
| **Result Memory**    | Output storage         | 16×32-bit array               |
| **Peripheral Interface** | Visualization      | Hex displays + LEDs           |


# Brief Description : 

This project uses the Cyclone V Altera FPGA to do complex computation of a maclaurin series term :  x - x²/2 + x³/3 - x⁴/4, for different ranges of x values from x=-.9 to x=+.9 using the following steps : 

- Program the NIOS II CPU (PS) side through a SystemC code and assign it's I/O ports to communicate with the FPGA (PL) side. It is designed through Quartus Platform Designer and IP integrator and named as Solver. A block view of the Solver IP is following :


![solver_block](https://github.com/user-attachments/assets/77cc0d76-cdf4-43b6-a0f2-f7277fecc3dc)


    
- The SystemC code is used to assign identifiers (i.e start, done, clk, reset, result) (to the following I/O registers with memory-mapped addresses :

1. **`X_PIO_BASE`**  
2. **`START_PIO_BASE`**  
3. **`RESULT_PIO_BASE`**  
4. **`DONE_PIO_BASE`**

- The SystemC code also programs the CPU (PS) side to perform operations in the following sequential manner :

![flow_diagram_NIOS_II](https://github.com/user-attachments/assets/e7698f4c-c5f9-4625-b341-6d76b81c2a56)



- On the FPGA (PL) side, an FSM named monitor.v was written to send stimulus to the PS (CPU) side and retrieve the generated outputs to store on the FPGA on-chip RAM

- the hex_displays.v and top.v RTL files were written to connect the NIOS II CPU IP (solver.v) and the FPGA fabric, as well as to show the outputs recorded in the FPGA on-chip RAM through the hex displays using Switches (SW)


  

# Steps to run project : 

- Import the archived project named solver_FARHAN to Quartus project archive opener
- Upload the smaller_sereis.elf file to Platform IP designer to program the NIOS II CPU
- Import the hello_world.c file to Eclipse platform to assign the CPU I/Os
- While programming the FPGA through JTAG, upload the solver_time_limited.sof file 



## NIOS II Architecture Explanation (Video)

- **Click the following thumbnail to see explanation of NIOS II architecture and I/O programming**  

[![Nios II Explanation Thumbnail](https://github.com/muhammadfarhan720/Softcore-CPU-Solver/blob/main/images/NIOS_II_explain.jpg)](https://drive.google.com/file/d/1OivlKEcWBMbtK8nlybsaeRTyZyXZcWzh/view?usp=sharing)




## FPGA (PL) side RTL explanation (Video)

- **Click the following thumbnail to see explanation of RTL programming from FPGA fabric (i.e FSM, hex_diplay and Top file glue logic)** 


[![RTL Explanation Thumbnail](https://raw.githubusercontent.com/muhammadfarhan720/Softcore-CPU-Solver/main/images/RTL_explain_PL.jpg)](https://drive.google.com/file/d/1d1RwWHCYOZGS5YGcJ9evYmTbsL30fEU4/view?usp=sharing)
