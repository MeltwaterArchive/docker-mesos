#!/bin/sh
set -e -x
env

# Decrypt environment variables
SECRETS=$(secretary decrypt -e --service-key=/service/keys/service-private-key.pem)

# Output the secrets to the container log for debug purposes (don't do this in any remotely real situation!)
echo "Decrypted secrets are:"
echo "$SECRETS"

# Source the secrets into the env
eval "$SECRETS"

# Start the main app
exec python app.py
