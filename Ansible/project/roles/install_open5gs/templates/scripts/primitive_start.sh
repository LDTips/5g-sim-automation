#!/bin/bash

# THIS IS A VERY PRIMITIVE VERSION. IN DEVELOPMENT!
# To add a config write "-c /path/to/config.yaml" after the daemon path
# e.g. /bin/open5gs-amfd -c /path/to/some/amf_config.yaml &
/bin/open5gs-nrfd &
sleep 1
/bin/open5gs-scpd &
sleep 1
/bin/open5gs-amfd &
sleep 1
/bin/open5gs-smfd &
sleep 1
/bin/open5gs-ausfd &
sleep 1
/bin/open5gs-udmd &
sleep 1
/bin/open5gs-udrd &
sleep 1
/bin/open5gs-pcfd &
sleep 1
/bin/open5gs-nssfd &
sleep 1
/bin/open5gs-bsfd &
sleep 1
/bin/open5gs-upfd &