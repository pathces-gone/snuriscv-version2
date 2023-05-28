# Project Version2 Overview:
:smile: Evan.Park
:date: 2023.05.28

## :one: Simulation Environments:
  1. Xilinx 2022.2
  2. Ubuntu 

> Synthesis (FPGA) may be working at version 3 ..

## :two: Build System:
  1. CMake
  2. doxygen (maybe..)

## :three: Core Design:
  1. same as version1

## :four: How to build project:
* Run tasks.json (`ctrl+shift+B`)
  1. CMake Build
  2. Make sim
  3. Show WAVE
  4. Make sim-clean or CMake Clean


-----
# How to installation Xilinx:

##  :cyclone:Installation Guide (with ChatGPT)
As an AI language model, I can provide you with general instructions on how to install Vivado 2022.2. Please note that the specific installation steps may vary based on your operating system (Windows, macOS, or Linux). The following steps outline a typical installation process:

1. Visit the Xilinx website: Go to the Xilinx website (www.xilinx.com) and navigate to the "Downloads" section. Ensure that you have a valid account and access to the Vivado 2022.2 installation files.

2. Download the Vivado 2022.2 installer: Locate the Vivado 2022.2 installer file for your operating system and download it to your computer. Make sure you download the appropriate version for your OS (Windows, macOS, or Linux).

3. Run the installer: Once the installer file is downloaded, locate it on your computer and run it. Follow the on-screen instructions to begin the installation process.

4. Accept the license agreement: Read and accept the Xilinx End User License Agreement (EULA) to proceed with the installation. If you agree to the terms, click "Next" or "Agree" to continue.

5. Choose installation options: Select the components you want to install. Vivado offers various options, including the Vivado Design Suite, Software Development Kit (SDK), Documentation, and additional plug-ins. Choose the components based on your requirements and click "Next" to proceed.

6. Select installation location: Choose the directory where you want to install Vivado 2022.2. The installer may suggest a default location, but you can modify it if needed. Click "Next" to continue.

7. Configure Xilinx license: If you have a Xilinx license file, you can configure it during the installation process. Follow the instructions provided by the installer to set up your license or choose the option for a 30-day evaluation license.

8. Start the installation: Review the installation summary, ensuring that all the selected options and settings are correct. If everything looks good, click "Install" to begin the installation process.

9. Wait for the installation to complete: The installer will extract and install the necessary files. This process may take some time depending on your system's performance.

10. Complete the installation: Once the installation is finished, you will see a confirmation message. Click "Finish" to exit the installer.

After completing these steps, Vivado 2022.2 should be installed on your system. You can then launch Vivado from the installation directory or through the Start menu (Windows) or the Applications folder (macOS).

Remember to consult the official Xilinx documentation or the installation guide provided by Xilinx for more detailed instructions specific to your operating system if you encounter any difficulties during the installation process.

----
##  :cyclone:Trouble-shooting (with ChatGPT)
### Q1. how to install all libaraies related vivado2022.2 installation?
To install all the necessary libraries related to Vivado 2022.2 installation, you can follow these steps:

1. Update package lists: Open a terminal on your Linux system and run the following command to update the package lists:

   ```
   sudo apt update
   ```

2. Install required libraries: Execute the following command to install the necessary libraries:

   ```
   sudo apt install libxtst6 libxrender1 libxi6 libglib2.0-0 libfreetype6 libfontconfig1 libx11-6 libxext6 libxft2 libxau6 libxdmcp6 libxslt1.1 libxext6 libxinerama1 libxrandr2 libxfixes3 libxcursor1 libxshmfence1 libxrender-dev libxcomposite1 libxmu6 libglu1-mesa
   ```

   This command installs a set of libraries commonly required by Vivado and its associated tools.

3. Verify installation: After the installation is complete, you can check if the libraries are installed correctly. You can use the `dpkg -l` command to list the installed packages:

   ```
   dpkg -l | grep libxtst6
   dpkg -l | grep libxrender1
   dpkg -l | grep libxi6
   ...
   ```

   Make sure that the output shows the libraries you installed with their corresponding version numbers.

These steps should help you install the necessary libraries related to Vivado 2022.2 on your Linux system. Please note that the specific libraries required may vary depending on your system configuration and any additional features or tools you choose during the Vivado installation process.

### Q2. how to fix this vivado installation bug?: " warning:setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory"

The warning you encountered during Vivado installation indicates that the specified locale "en_US.UTF-8" is not available on your system. However, you can resolve this issue by generating and setting the locale manually. Here's how you can do it:

1. Open a terminal on your Linux system.

2. Check available locales: Run the following command to view the available locales on your system:

   ```
   locale -a
   ```

   This command will display a list of available locales.

3. Generate the missing locale: If "en_US.UTF-8" is not listed in the output of the previous command, you can generate it by running the following command:

   ```
   sudo locale-gen en_US.UTF-8
   ```

   This command will generate the "en_US.UTF-8" locale.

4. Set the locale: To set the generated locale as the default for your system, execute the following command:

   ```
   sudo update-locale LANG=en_US.UTF-8
   ```

   This command sets the "en_US.UTF-8" locale as the default for your system.

5. Reboot your system: It is recommended to reboot your Linux system for the changes to take effect. You can do this by running the following command:

   ```
   sudo reboot
   ```

   After the system restarts, the locale should be set correctly.

Once you have completed these steps, you can try reinstalling Vivado. The warning about the locale should no longer appear, and the installation should proceed without issues.

-----
# Core Design:
## A. RISC-V Core Design
![](doc/image/snurisc-seq.png)

-----
## B. Simulation Result
### Program
      addi t1, zero, 8
      lw t3,0(t1)
      addi t1, zero, 4
      sw t3,4(t0)
      lw t4,0(t1)
      nop
      addi t1,zero,4
      addi t2,zero,4
      beq t1,t2,256
    
    256:
      addi t3,zero,0xf

-----
### Result
![]()


------
## Reference

[Computer Architecture (Fall 2020)](http://csl.snu.ac.kr/courses/4190.308/2020-2/)


