##########################################################################################################################
# File automatically-generated by tool: [projectgenerator] version: [3.0.0] date: [Sat Jan 12 15:00:44 CST 2019]
##########################################################################################################################

# ------------------------------------------------
# Generic Makefile (based on gcc)
#
# ChangeLog :
#	2017-02-10 - Several enhancements + project update mode
#   2015-07-22 - first version
# ------------------------------------------------

######################################
# target
######################################
TARGET = Apache-NimBLE


######################################
# building variables
######################################
# debug build?
DEBUG = 1
# optimization
OPT = -Og


#######################################
# paths
#######################################
# Build path
BUILD_DIR = _build

# Configure NimBLE variables
NIMBLE_ROOT := NimBLE
NIMBLE_CFG_TINYCRYPT := 1
include $(NIMBLE_ROOT)/porting/nimble/Makefile.defs
include Makefile.controller


######################################
# source
######################################
# C sources
C_SOURCES =  \
CMSIS/Device/Source/system_BlueNRG1.c \
Project/Source/main.c \
Project/Source/BlueNRG1_it.c \
Project/Source/ble_hw.c \
Project/Source/ble_phy.c \
Project/Source/hal_timers.c \
BSP/Source/SDK_EVAL_Config.c \
BSP/Source/SDK_EVAL_Button.c \
BSP/Source/SDK_EVAL_Led.c \
HAL/Source/miscutil.c \
Driver/Source/misc.c \
Driver/Source/BlueNRG1_sysCtrl.c \
Driver/Source/BlueNRG1_gpio.c \
Driver/Source/BlueNRG1_rtc.c \
Driver/Source/BlueNRG1_wdg.c \
FreeRTOS/lib/FreeRTOS/event_groups.c \
FreeRTOS/lib/FreeRTOS/list.c \
FreeRTOS/lib/FreeRTOS/queue.c \
FreeRTOS/lib/FreeRTOS/stream_buffer.c \
FreeRTOS/lib/FreeRTOS/tasks.c \
FreeRTOS/lib/FreeRTOS/timers.c \
FreeRTOS/lib/FreeRTOS/portable/GCC/ARM_CM0/port.c \
FreeRTOS/lib/FreeRTOS/portable/MemMang/heap_4.c \
FreeRTOS/lib/third_party/tracealyzer_recorder/streamports/Jlink_RTT/SEGGER_RTT_Printf.c \
FreeRTOS/lib/third_party/tracealyzer_recorder/streamports/Jlink_RTT/SEGGER_RTT.c \
NimBLE/porting/npl/freertos/src/nimble_port_freertos.c \
NimBLE/porting/npl/freertos/src/npl_os_freertos.c \
$(NIMBLE_SRC) \
$(TINYCRYPT_SRC)


# ASM sources
ASM_SOURCES = 

#######################################
# binaries
#######################################
PREFIX = arm-none-eabi-
# The gcc compiler bin path can be either defined in make command via GCC_PATH variable (> make GCC_PATH=xxx)
# either it can be added to the PATH environment variable.
ifdef GCC_PATH
CC = $(GCC_PATH)/$(PREFIX)gcc
AS = $(GCC_PATH)/$(PREFIX)gcc -x assembler-with-cpp
CP = $(GCC_PATH)/$(PREFIX)objcopy
SZ = $(GCC_PATH)/$(PREFIX)size
else
CC = $(PREFIX)gcc
AS = $(PREFIX)gcc -x assembler-with-cpp
CP = $(PREFIX)objcopy
SZ = $(PREFIX)size
endif
HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S
 
#######################################
# CFLAGS
#######################################
# cpu
CPU = -mcpu=cortex-m0

# fpu
# NONE for Cortex-M0/M0+/M3

# float-abi


# mcu
MCU = $(CPU) -mthumb $(FPU) $(FLOAT-ABI)

# macros for gcc
# AS defines
AS_DEFS = 

# C defines
C_DEFS =  \
-D USE_FULL_ASSERT \
-D BLUENRG2_DEVICE \
-D NO_SMART_POWER_MANAGEMENT \
-D HS_SPEED_XTAL=HS_SPEED_XTAL_32MHZ


# AS includes
AS_INCLUDES = 

# C includes
C_INCLUDES =  \
-ICMSIS/Include \
-ICMSIS/Device/Include \
-IProject/Include \
-IBSP/Include \
-IHAL/Include \
-IDriver/Include \
-IFreeRTOS/lib/include \
-IFreeRTOS/lib/include/private \
-IFreeRTOS/lib/FreeRTOS/portable/GCC/ARM_CM0 \
-IFreeRTOS/lib/third_party/tracealyzer_recorder/streamports/Jlink_RTT/include \
-INimBLE/porting/npl/freertos/include \
$(addprefix -I, $(NIMBLE_INCLUDE)) \
$(addprefix -I, $(TINYCRYPT_INCLUDE))


# compile gcc flags
ASFLAGS = $(MCU) $(AS_DEFS) $(AS_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

CFLAGS = $(MCU) $(C_DEFS) $(C_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections $(NIMBLE_CFLAGS) $(TINYCRYPT_CFLAGS)

ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif


# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"


#######################################
# LDFLAGS
#######################################
# link script
LDSCRIPT = BlueNRG2.ld

# libraries
LIBS = -lc -lm -lnosys 
LIBDIR = 
LDFLAGS = $(MCU) -specs=nano.specs -T$(LDSCRIPT) $(LIBDIR) $(LIBS) -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections

# default action: build all
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin


#######################################
# build the application
#######################################
# list of objects
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))
# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR)
	@echo CC $<
	@$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	@echo AS $<
	@$(AS) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	@echo LD $@
	@echo
	@$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	@$(SZ) $@
	@echo

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	@$(HEX) $< $@
	
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	@$(BIN) $< $@	
	
$(BUILD_DIR):
	mkdir $@		

#######################################
# clean up
#######################################
clean:
	-rm -rf $(BUILD_DIR)
  
#######################################
# dependencies
#######################################
-include $(wildcard $(BUILD_DIR)/*.d)

# *** EOF ***
