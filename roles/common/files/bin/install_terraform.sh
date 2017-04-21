#!/bin/bash

set -e

#TODO: Add checksum signing verification

confirm() {
        echo -n "$1 "
        read ans
        case "$ans" in
        y|Y|yes|YES|Yes) return 0 ;;
        *) echo Exiting; return 1 ;;
        esac
}

terraform_ver='0.9.3'
terraform_zip="terraform_${terraform_ver}_linux_amd64.zip"
terraform_url="https://releases.hashicorp.com/terraform"
terraform_dl_url="${terraform_url}/${terraform_ver}/${terraform_zip}"
terraform_sums="${terraform_url}/${terraform_ver}/terraform_${terraform_ver}_SHA256SUMS"

curl ${terraform_dl_url} -sSL -o /tmp/${terraform_zip}

expected_zip_sum=$(curl -sSL ${terraform_sums} | grep ${terraform_zip} |awk '{print $1}')

actual_zip_sum=$(sha256sum /tmp/${terraform_zip} | awk '{print $1}')

echo "Terraform Sums"
echo Expected: $expected_zip_sum
echo Actual: $actual_zip_sum

echo "Proceed with install? (y/n)"

confirm && sudo unzip -d /usr/local/bin /tmp/${terraform_zip}

terraform --version
