#!/bin/bash

grep -E '"data": "42\[\\"qs\\",\\"QR\|#NQMAR25\|[0-9]{5}' stream.har >stream.txt

START=$(head -n1 stream.txt | cut -d "|" -f 5 | tr -d '\\"]')

END=$(tail -n1 stream.txt | cut -d "|" -f 5 | tr -d '\\"]')

if [[ $START = "" ]]; then
    date >>errors.log
    exit
fi

sed -E 's/.*([0-9]{5}\.[0-9]{2}\|[0-9]{5}\.[0-9|.]*).*/\1/' stream.txt >data.txt

COUNTER=1

for i in $(seq $START 1000 $END); do
    LINE=$(head -n $COUNTER ./data.txt | tail -n1)
    TIME=$(echo "$LINE" | cut -d "|" -f 3)
    SELL=$(echo "$LINE" | cut -d "|" -f 1)
    BUY=$(echo "$LINE" | cut -d "|" -f 2)

    NEXT_LINE=$(head -n $((COUNTER + 1)) ./data.txt | tail -n1)
    NEXT_TIME=$(echo "$NEXT_LINE" | cut -d "|" -f 3)
    NEXT_SELL=$(echo "$NEXT_LINE" | cut -d "|" -f 1)
    NEXT_BUY=$(echo "$NEXT_LINE" | cut -d "|" -f 2)

    if [[ ($i -gt $TIME || $i -eq $TIME) && $i -lt $NEXT_TIME ]]; then
        echo "$SELL $BUY" >>"$START-$END"
    fi

    if [[ $i -eq $NEXT_TIME || $i -gt $NEXT_TIME ]]; then
        echo "$NEXT_SELL $NEXT_BUY" >>"$START-$END"
        COUNTER=$((COUNTER + 1))
    fi
done

mv "$START-$END" ./data/
rm ./stream.txt ./data.txt
mv ./stream.har ./raw/"$START-$END.har"

START_DATE=$(date -d "@$((START / 1000))")
END_DATE=$(date -d "@$((END / 1000))")

echo "$START_DATE - $END_DATE" >>./times.log
