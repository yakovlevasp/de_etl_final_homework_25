#!/usr/bin/env bash
export YDB_ENDPOINT="$(terraform output -raw ydb_full_endpoint)"
export YDB_DATABASE="$(terraform output -raw ydb_database_path)"

ydb -e $YDB_ENDPOINT \
    -d $YDB_DATABASE \
    --yc-token-file oauth-token.txt \
    scripting yql -f create_table.yql

ydb -e $YDB_ENDPOINT \
    -d $YDB_DATABASE \
    --yc-token-file oauth-token.txt \
    import file csv transactions_v2.csv \
    --columns "transaction_id,merchant,mcc,currency,amount,transaction_date,card_id,card_type,gender,age,country" \
    --path transactions