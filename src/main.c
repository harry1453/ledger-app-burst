/*******************************************************************************
*   Ledger Blue
*   (c) 2016 Ledger
*
*  Licensed under the Apache License, Version 2.0 (the "License");
*  you may not use this file except in compliance with the License.
*  You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
*  Unless required by applicable law or agreed to in writing, software
*  distributed under the License is distributed on an "AS IS" BASIS,
*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*  See the License for the specific language governing permissions and
*  limitations under the License.
********************************************************************************/

#include "os.h"
#include "cx.h"
#include "curve/curve25519_i64.h"

#include "os_io_seproxyhal.h"
#include "rs/rs_address.h"

#include "glyphs/glyphs.h"

unsigned char G_io_seproxyhal_spi_buffer[IO_SEPROXYHAL_BUFFER_SIZE_B];

static unsigned char hashTainted;     // notification to restart the hash

ux_state_t ux;

static const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e);
static const bagl_element_t*
io_seproxyhal_touch_approve(const bagl_element_t *e);
static const bagl_element_t *io_seproxyhal_touch_deny(const bagl_element_t *e);
static void showIdleUI();

#define CLA 0x80
#define INS_SIGN 0x02
#define INS_GET_PUBLIC_KEY 0x04
#define P1_LAST 0x80
#define P1_MORE 0x00
#define RESP_OK 0x4b

#define ERR_NOT_LONG_ENOUGH 0x6464

static cx_sha256_t hash;

typedef struct signingContext_t {
    unsigned char feesAmount[32];
    unsigned char transactionAmount[32];
    unsigned char recipientRs[32];
    unsigned char lastIndex;
    unsigned char privateKey[32];
    unsigned char sharedKey[32];
    unsigned char publicKey[32];
    unsigned char h[32];
    unsigned char m[32];
    unsigned char x[32];
    unsigned char y[32];
} messageSigningContext_t;

static int ux_step;
static int ux_step_count;

static messageSigningContext_t signingContext;

// TODO nvram storage of last used key

void getKeys() {
    if (!os_global_pin_is_validated()) {
        return;
    }

    unsigned char newIndex = G_io_apdu_buffer[3];
    if (signingContext.lastIndex == newIndex) {
        return;
    }

    signingContext.lastIndex = newIndex;

    // BURST keypath of 44'/30'/0'/0'/index'
    uint32_t purpose = 44; // BIP 44
    uint32_t coinType = 30; // Burstcoin
    uint32_t account = 0;
    uint32_t change = 0; // External chain
    uint32_t index = signingContext.lastIndex;
    uint32_t path[] = {purpose | 0x80000000, coinType | 0x80000000, account | 0x80000000, change | 0x80000000, index | 0x80000000};

    os_perso_derive_node_bip32(CX_CURVE_Ed25519, path, 5, signingContext.privateKey, NULL);
    keygen25519(signingContext.publicKey, signingContext.sharedKey, signingContext.privateKey);
}

static void printAmount(uint64_t amount, unsigned char *out, uint8_t len) {
    char buffer[len];
    uint64_t dVal = amount;
    int i, j;

    os_memset(buffer, 0, len);
    for (i = 0; dVal > 0 || i < 9; i++) {
        if (dVal > 0) {
            buffer[i] = (dVal % 10) + '0';
            dVal /= 10;
        } else {
            buffer[i] = '0';
        }
        if (i == 7) { // 1 BURST = 100000000 quants
            i += 1;
            buffer[i] = '.';
        }
        if (i >= len) {
            THROW(0x6700);
        }
    }
    // reverse order
    for (i -= 1, j = 0; i >= 0 && j < len-1; i--, j++) {
        out[j] = buffer[i];
    }
    // strip trailing 0s
    for (j -= 1; j > 0; j--) {
        if (out[j] != '0') break;
    }
    j += 2;

    out[j++] = ' ';
    out[j++] = 'B';
    out[j++] = 'U';
    out[j++] = 'R';
    out[j++] = 'S';
    out[j++] = 'T';
    out[j] = '\0';
}

const ux_menu_entry_t menu_main[] = {
        {NULL, NULL, 0, &C_icon_burst, "Use wallet to", "view accounts", 33, 12},
        {NULL, NULL, 0, NULL, "Version", APPVERSION, 0, 0},
        {NULL, os_sched_exit, 0, &C_icon_dashboard, "Quit app", NULL, 50, 29},
        UX_MENU_END};

const bagl_element_t ui_verify[] = {
        {{BAGL_RECTANGLE, 0x00, 0, 0, 128, 32, 0, 0, BAGL_FILL, 0x000000, 0xFFFFFF, 0, 0},
                NULL,
                0,
                0,
                0,
                NULL,
                NULL,
                NULL},

        {{BAGL_ICON, 0x00, 3, 12, 7, 7, 0, 0, 0, 0xFFFFFF, 0x000000, 0, BAGL_GLYPH_ICON_CROSS},
                NULL,
                0,
                0,
                0,
                NULL,
                NULL,
                NULL},
        {{BAGL_ICON, 0x00, 117, 13, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0, BAGL_GLYPH_ICON_CHECK},
                NULL,
                0,
                0,
                0,
                NULL,
                NULL,
                NULL},
        {{BAGL_LABELINE, 0x01, 0, 12, 128, 12, 0, 0, 0, 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
                "Confirm",
                0,
                0,
                0,
                NULL,
                NULL,
                NULL},
        {{BAGL_LABELINE, 0x01, 0, 26, 128, 12, 0, 0, 0, 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
                "transaction",
                0,
                0,
                0,
                NULL,
                NULL,
                NULL},

        {{BAGL_LABELINE, 0x02, 0, 12, 128, 12, 0, 0, 0, 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
                "Amount",
                0,
                0,
                0,
                NULL,
                NULL,
                NULL},
        {{BAGL_LABELINE, 0x02, 23, 26, 82, 12, 0x80 | 10, 0, 0, 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px | BAGL_FONT_ALIGNMENT_CENTER, 26},
                signingContext.transactionAmount,
                0,
                0,
                0,
                NULL,
                NULL,
                NULL},

        {{BAGL_LABELINE, 0x03, 0, 12, 128, 12, 0, 0, 0, 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
                "Address",
                0,
                0,
                0,
                NULL,
                NULL,
                NULL},
        {{BAGL_LABELINE, 0x03, 23, 26, 82, 12, 0x80 | 10, 0, 0, 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px | BAGL_FONT_ALIGNMENT_CENTER, 26},
                signingContext.recipientRs,
                0,
                0,
                0,
                NULL,
                NULL,
                NULL},

        {{BAGL_LABELINE, 0x04, 0, 12, 128, 12, 0, 0, 0, 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
                "Fees",
                0,
                0,
                0,
                NULL,
                NULL,
                NULL},
        {{BAGL_LABELINE, 0x04, 23, 26, 82, 12, 0x80 | 10, 0, 0, 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px | BAGL_FONT_ALIGNMENT_CENTER, 26},
                signingContext.feesAmount,
                0,
                0,
                0,
                NULL,
                NULL,
                NULL},
};

static unsigned int ui_verify_button(unsigned int button_mask, unsigned int button_mask_counter) {
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        io_seproxyhal_touch_approve(NULL);
        break;

    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        io_seproxyhal_touch_deny(NULL);
        break;
    }
    return 0;
}

static const bagl_element_t*
io_seproxyhal_touch_approve(const bagl_element_t *e) {
    unsigned int tx = 0;
    if (G_io_apdu_buffer[2] == P1_LAST) {
        // Hash is finalized, send back the signature

        // Get keys
        getKeys();

        // Get m (messageHash)
        cx_hash(&hash.header, CX_LAST, NULL, 0, signingContext.m, 32);

        // Get x = hash(m, s)
        cx_sha256_init(&hash);
        cx_hash(&hash.header, 0, signingContext.m, 32, NULL, 0);
        cx_hash(&hash.header, CX_LAST, signingContext.m, 32, signingContext.x, 32);

        // get y through keygen25519(y, NULL, x);
        keygen25519(signingContext.y, NULL, signingContext.x);

        // h = hash(m, y);
        cx_sha256_init(&hash);
        cx_hash(&hash.header, 0, signingContext.m, 32, NULL, 0);
        cx_hash(&hash.header, CX_LAST, signingContext.y, 32, signingContext.h, 32);

        // sign25519(v, h, x, s);
        sign25519(G_io_apdu_buffer, signingContext.h, signingContext.x, signingContext.sharedKey);
        os_memcpy(G_io_apdu_buffer+32, signingContext.h, 32);

        // return 64 bytes to host
        tx=64;
        hashTainted = 1;
    }
    G_io_apdu_buffer[tx++] = 0x90;
    G_io_apdu_buffer[tx++] = 0x00;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
    // Display back the original UX
    showIdleUI();
    return 0; // do not redraw the widget
}

static const bagl_element_t *io_seproxyhal_touch_deny(const bagl_element_t *e) {
    hashTainted = 1;
    G_io_apdu_buffer[0] = 0x69;
    G_io_apdu_buffer[1] = 0x85;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
    // Display back the original UX
    showIdleUI();
    return 0; // do not redraw the widget
}

unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
    switch (channel & ~(IO_FLAGS)) {
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);

            if (channel & IO_RESET_AFTER_REPLIED) {
                reset();
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}

const bagl_element_t * ui_verify_prepro(const bagl_element_t *element) {
    if (element->component.userid > 0) {
        unsigned int display = (ux_step == element->component.userid - 1);
        if (display) {
            switch (element->component.userid) {
                case 1:
                    UX_CALLBACK_SET_INTERVAL(2000);
                    break;
                case 2:
                case 3:
                case 4:
                    UX_CALLBACK_SET_INTERVAL(MAX(
                                                     3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));
                    break;
            }
        }
        if (!display)
            return NULL;
    }
    return element;
}

static void showIdleUI(void) {
    UX_MENU_DISPLAY(0, menu_main, NULL);
}

static void showVerifyUI(void) {
    ux_step = 0;
    ux_step_count = 4;
    UX_DISPLAY(ui_verify, ui_verify_prepro);
}

static void sample_main(void) {
    volatile unsigned int rx = 0;
    volatile unsigned int tx = 0;
    volatile unsigned int flags = 0;


    // next timer callback in 500 ms
    UX_CALLBACK_SET_INTERVAL(500);

    // DESIGN NOTE: the bootloader ignores the way APDU are fetched. The only
    // goal is to retrieve APDU.
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
                tx = 0; // ensure no race in catch_other if io_exchange throws
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    THROW(0x6982);
                }

                if (G_io_apdu_buffer[0] != CLA) {
                    THROW(0x6E00);
                }

                switch (G_io_apdu_buffer[1]) {
                case INS_SIGN: {
                    if ((G_io_apdu_buffer[2] != P1_MORE) &&
                        (G_io_apdu_buffer[2] != P1_LAST)) {
                        THROW(0x6A86);
                    }

                    if (hashTainted) {
                        cx_sha256_init(&hash);
                        if (G_io_apdu_buffer[4] < 176) { // Less than base transaction size
                            THROW(ERR_NOT_LONG_ENOUGH);
                        }

                        // Get the basic tranasction information
                        uint64_t recipient, fee, amount;
                        os_memmove(&recipient, G_io_apdu_buffer + 5 + 40, 8);
                        os_memmove(&amount, G_io_apdu_buffer + 5 + 48, 8);
                        os_memmove(&fee, G_io_apdu_buffer + 5 + 56, 8);
                        addressFromAccountNumber(signingContext.recipientRs, recipient, true);
                        printAmount(amount, signingContext.transactionAmount,
                                    sizeof(signingContext.transactionAmount));
                        printAmount(fee, signingContext.feesAmount,
                                    sizeof(signingContext.feesAmount));
                        hashTainted = 0;
                    }

                    // Update the hash
                    cx_hash(&hash.header, 0, G_io_apdu_buffer + 5, G_io_apdu_buffer[4], NULL, 0);

                    if (G_io_apdu_buffer[2] == P1_LAST) {
                        G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
                        showVerifyUI();
                        flags |= IO_ASYNCH_REPLY;
                    } else {
                        G_io_apdu_buffer[1] = RESP_OK;
                        tx = 1;
                        THROW(0x9000);
                    }
                } break;

                case INS_GET_PUBLIC_KEY: {
                    getKeys();
                    os_memcpy(G_io_apdu_buffer, signingContext.publicKey, 32);
                    tx = 32;
                    THROW(0x9000);
                } break;

                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                default:
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
                switch (e & 0xF000) {
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
                G_io_apdu_buffer[tx + 1] = sw;
                tx += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
    }

return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
}

unsigned char io_event(unsigned char channel) {
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        UX_DISPLAYED_EVENT();
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
                ux_step = (ux_step + 1) % ux_step_count;
                UX_REDISPLAY();
        });
        break;

    // unknown events are acknowledged
    default:
        UX_DEFAULT_EVENT();
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
        io_seproxyhal_general_status();
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
}

__attribute__((section(".boot"))) int main(void) {
    // exit critical section
    __asm volatile("cpsie i");

    hashTainted = 1;

    // ensure exception will work as planned
    os_boot();

    UX_INIT();

    BEGIN_TRY {
        TRY {
            io_seproxyhal_init();
#ifdef LISTEN_BLE
            if (os_seph_features() &
                SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_BLE) {
                BLE_power(0, NULL);
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
            USB_power(1);

            showIdleUI();

            sample_main();
        }
        CATCH_OTHER(e) {
        }
        FINALLY {
        }
    }
    END_TRY;
}
