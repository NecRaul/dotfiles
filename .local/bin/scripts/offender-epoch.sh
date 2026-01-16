#!/bin/bash

fd -t f | tee \
    >(rg --pcre2 '(?<=^|/)\d{13,15}(?=[ .m])[^/]*$' | sort >offender-epoch-millis) \
    >(rg --pcre2 '(?<=^|/)\d{16}(?= )[^/]*$' | sort >offender-epoch-micros) \
    >/dev/null
