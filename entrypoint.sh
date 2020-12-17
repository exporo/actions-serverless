#!/bin/sh -l

echo "Stage $1"
echo "Profile: $2"
echo "Region: $3"
echo "Command: $6"
echo "Directory: $7"

mkdir ~/.aws
rm ~/.aws/credentials
rm ~/.aws/config
printf "[$2]\naws_access_key_id = $4\naws_secret_access_key = $5" >> ~/.aws/credentials
printf "[$2]\nregion = $3" >> ~/.aws/config
# creating ssh file is required for `sls remove`
mkdir ~/.ssh
rm ~/.ssh/$2-$1
touch  ~/.ssh/$2-$1

cd $7
serverless $6 --stage $1 --aws-profile $2
