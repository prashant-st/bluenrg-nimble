/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

#include <string.h>
#include <stdint.h>
#include <assert.h>
#include <errno.h>
#include "hal/hal_timer.h"

#define __HAL_DISABLE_INTERRUPTS(x)                     \
    do {                                                \
        x = __get_PRIMASK();                            \
        __disable_irq();                                \
    } while(0);

#define __HAL_ENABLE_INTERRUPTS(x)                      \
    do {                                                \
        if (!x) {                                       \
            __enable_irq();                             \
        }                                               \
    } while(0);

/* IRQ prototype */
typedef void (*hal_timer_irq_handler_t)(void);

/* User CC 2 for reading counter, CC 3 for timer isr */
#define NRF_TIMER_CC_READ       (2)
#define NRF_TIMER_CC_INT        (3)

/* Output compare 2 used for RTC timers */
#define NRF_RTC_TIMER_CC_INT    (2)

/* Maximum number of hal timers used */
#define NRF52_HAL_TIMER_MAX     (6)

/* Maximum timer frequency */
#define NRF52_MAX_TIMER_FREQ    (16000000)

struct nrf52_hal_timer {
    uint8_t tmr_enabled;
    uint8_t tmr_irq_num;
    uint8_t tmr_rtc;
    uint8_t tmr_pad;
    uint32_t tmr_cntr;
    uint32_t timer_isrs;
    uint32_t tmr_freq;
    void *tmr_reg;
    
};





/* Resolve timer number into timer structure */
#define NRF52_HAL_TIMER_RESOLVE(__n, __v)       \
    if ((__n) >= NRF52_HAL_TIMER_MAX) {         \
        rc = EINVAL;                            \
        goto err;                               \
    }                                           \
    (__v) = (struct nrf52_hal_timer *) nrf52_hal_timers[(__n)];            \
    if ((__v) == NULL) {                        \
        rc = EINVAL;                            \
        goto err;                               \
    }

/* Interrupt mask for interrupt enable/clear */
#define NRF_TIMER_INT_MASK(x)    ((1 << (uint32_t)(x)) << 16)


/**
 * hal timer init
 *
 * Initialize platform specific timer items
 *
 * @param timer_num     Timer number to initialize
 * @param cfg           Pointer to platform specific configuration
 *
 * @return int          0: success; error code otherwise
 */
int
hal_timer_init(int timer_num, void *cfg)
{
    return 0;
}

/**
 * hal timer config
 *
 * Configure a timer to run at the desired frequency. This starts the timer.
 *
 * @param timer_num
 * @param freq_hz
 *
 * @return int
 */
int
hal_timer_config(int timer_num, uint32_t freq_hz)
{
    return 0;
}

/**
 * hal timer deinit
 *
 * De-initialize a HW timer.
 *
 * @param timer_num
 *
 * @return int
 */
int
hal_timer_deinit(int timer_num)
{
    return 0;
}

/**
 * hal timer get resolution
 *
 * Get the resolution of the timer. This is the timer period, in nanoseconds
 *
 * @param timer_num
 *
 * @return uint32_t The
 */
uint32_t
hal_timer_get_resolution(int timer_num)
{
    return 0;
}

/**
 * hal timer read
 *
 * Returns the timer counter. NOTE: if the timer is a 16-bit timer, only
 * the lower 16 bits are valid. If the timer is a 64-bit timer, only the
 * low 32-bits are returned.
 *
 * @return uint32_t The timer counter register.
 */
uint32_t
hal_timer_read(int timer_num)
{
    return 0;
}

/**
 * hal timer delay
 *
 * Blocking delay for n ticks
 *
 * @param timer_num
 * @param ticks
 *
 * @return int 0 on success; error code otherwise.
 */
int
hal_timer_delay(int timer_num, uint32_t ticks)
{
    return 0;
}

/**
 *
 * Initialize the HAL timer structure with the callback and the callback
 * argument. Also initializes the HW specific timer pointer.
 *
 * @param cb_func
 *
 * @return int
 */
int
hal_timer_set_cb(int timer_num, struct hal_timer *timer, hal_timer_cb cb_func,
                 void *arg)
{
    return 0;
}

int
hal_timer_start(struct hal_timer *timer, uint32_t ticks)
{
    return 0;
}

int
hal_timer_start_at(struct hal_timer *timer, uint32_t tick)
{
    return 0;
}

/**
 * hal timer stop
 *
 * Stop a timer.
 *
 * @param timer
 *
 * @return int
 */
int
hal_timer_stop(struct hal_timer *timer)
{
    return 0;
}
