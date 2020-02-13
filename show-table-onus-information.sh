#/bin/bash
clear
echo "Obtendo dados da OLT ..."
RETORNO_ONU_MAC=$(snmpwalk -v2c -c adsl 172.16.20.230 authOnuListMac | grep -n .)
RETORNO_ONU_STATUS=$(snmpwalk -v2c -c adsl 172.16.20.230 onuStatus)
RETORNO_ONU_ID=$(snmpwalk -v2c -c adsl 172.16.20.230 authOnuListOnuId)
RETORNO_ONU_PON=$(snmpwalk -v2c -c adsl 172.16.20.230 authOnuListPon)
RETORNO_ONU_SLOT=$(snmpwalk -v2c -c adsl 172.16.20.230 authOnuListSlot)
clear
echo -e ${RETORNO_ONU_MAC//GEPON-OLT-COMMON-MIB::authOnuListMac.[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9] = STRING:/} | sed 's/: /:/g' | sed 's/ /\n/g' > /tmp/onu_mac
echo -e ${RETORNO_ONU_STATUS//GEPON-OLT-COMMON-MIB::onuStatus.[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9] = INTEGER:/} | sed 's/: /:/g' | sed 's/1/UP/g' | sed 's/2/DOWN/g' | sed 's/0/DOWN/g' | sed 's/ /\n/g' > /tmp/onu_status
echo -e ${RETORNO_ONU_SLOT//GEPON-OLT-COMMON-MIB::authOnuListSlot.[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9] = INTEGER:/} |  sed 's/ /\n/g' > /tmp/onu_slot
echo -e ${RETORNO_ONU_PON//GEPON-OLT-COMMON-MIB::authOnuListPon.[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9] = INTEGER:/} |  sed 's/ /\n/g' > /tmp/onu_pon
echo -e ${RETORNO_ONU_ID//GEPON-OLT-COMMON-MIB::authOnuListOnuid.[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9] = INTEGER:/} |  sed 's/ /\n/g' > /tmp/onu_id

echo "-----Serial------ --Slot-- --Pon-- --Id-- -Status-"
paste /tmp/onu_mac /tmp/onu_slot /tmp/onu_pon /tmp/onu_id /tmp/onu_status
