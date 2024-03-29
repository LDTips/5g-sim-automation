#!/bin/bash


# Script adds all possible UE's to the C-Plane database
# By default the UE's are added to 'internet' APN. To add them to different APN, use:

# open5gs-dbctl add_ue_with_apn <imsi> <key> <opc> <apn>
# To remove a user: open5gs-dbctl remove <imsi>
# Remove all users: open5gs-dbctl reset

open5gs-dbctl add_ue_with_apn 999990000000000 465B5CE8B199B49FAA5F0A2EE238A6BC E8ED289DEBA952E4283B54E88E6183CA internet > /dev/null
open5gs-dbctl add_ue_with_apn 999990000000001 FEC86BA6EB707ED08905757B1BB44B8F E8ED289DEBA952E4283B54E88E6183CA internet > /dev/null
open5gs-dbctl add_ue_with_apn 999990000000002 9E5944AEA94B81165C82FBF9F32DB751 E8ED289DEBA952E4283B54E88E6183CA internet > /dev/null
open5gs-dbctl add_ue_with_apn 999990000000003 4AB1DEB05CA6CEB051FC98E77D026A84 E8ED289DEBA952E4283B54E88E6183CA internet > /dev/null
open5gs-dbctl add_ue_with_apn 999990000000004 6C38A116AC280C454F59332EE35C8C4F E8ED289DEBA952E4283B54E88E6183CA internet > /dev/null
open5gs-dbctl add_ue_with_apn 999990000000005 2D609D4DB0AC5BF0D2C0DE267014DE0D E8ED289DEBA952E4283B54E88E6183CA internet > /dev/null
