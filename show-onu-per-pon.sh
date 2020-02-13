#/bin/bash

RETORNO_OLT_PON_NAME=$(snmpwalk -v2c -c adsl 172.16.20.230 oltPonName |  grep -n .)
#snmpwalk -v2c -c adsl 172.16.20.230 authOnuListMac | grep -n .
RETORNO_OLT_PON_ONU_NUM=$(snmpwalk -v2c -c adsl 172.16.20.230 oltPonAuthOnuNum)
#snmpwalk -v2c -c adsl 172.16.20.230 onuStatus | grep -n . | sed 's/: //g' | sed 's/ /\n/g'

echo -e ${RETORNO_OLT_PON_NAME//GEPON-OLT-COMMON-MIB::oltPonName.[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9] = STRING:/} | sed 's/: /:/g' | sed 's/" /"\n/g' > /tmp/olt_pon_name
echo -e ${RETORNO_OLT_PON_ONU_NUM//GEPON-OLT-COMMON-MIB::oltPonAuthOnuNum.[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9] = INTEGER:/} | sed 's/: /:/g' | sed 's/ /\n/g' > /tmp/olt_pon_onu_num


echo "---PORTA PON--- -Quant. ONUs-"
paste /tmp/olt_pon_name /tmp/olt_pon_onu_num
