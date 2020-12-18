#!/bin/sh -l

if [[ -z "$6" ]]; then
  if [[ -z "${AWS_ACCESS_KEY_ID}" ]]; then
    echo "Set the AWS_ACCESS_KEY_ID env variable or pass aws-access-key-id parameter."
    exit 1
  fi
else
  AWS_ACCESS_KEY_ID=$6
fi

if [[ -z "$7" ]]; then
  if [[ -z "${AWS_SECRET_ACCESS_KEY}" ]]; then
    echo "Set the AWS_SECRET_ACCESS_KEY env variable or pass aws-secret-access-key parameter."
    exit 1
  fi
else
  AWS_SECRET_ACCESS_KEY=$7
fi

echo "Stage $1"
echo "Profile: $2"
echo "Region: $3"
echo "Command: $4"
echo "Directory: $5"

cp -f .npmrc ~/.npmrc
mkdir -p ~/.aws
rm -f ~/.aws/credentials
rm -f ~/.aws/config
printf "[$2]\naws_access_key_id = ${AWS_ACCESS_KEY_ID}\naws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}" >> ~/.aws/credentials
printf "[$2]\nregion = $3" >> ~/.aws/config

# creating ssh file is required for `sls remove`
mkdir -p  ~/.ssh
rm -f ~/.ssh/$2-$1
touch  ~/.ssh/$2-$1

cd $5
serverless $4 --stage $1 --aws-profile $2
