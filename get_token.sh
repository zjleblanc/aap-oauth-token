#!/bin/bash

DATA=$(curl -s -u $AAP_USER:$AAP_PWD -k -X POST https://$AAP_HOST/api/v2/tokens/)

TOKEN=$(echo $DATA | jq -r '.token')
USER_REF=$(echo $DATA | jq -r '.related.user')

export AAP_TOKEN=$TOKEN
USER=$(curl -s -k -X GET https://$AAP_HOST$USER_REF \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $AAP_TOKEN" \
)

echo "USER: $AAP_USER"
echo "TOKEN: $TOKEN"
echo "EXPIRATION: $(echo $DATA | jq -r '.expires')"
echo "SCOPE: $(echo $DATA | jq -r '.scope')"
echo "GET $USER_REF:"
echo $USER | python -m json.tool