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

# Utility function to launch service process as unprivileged user
# Usage: launch username command [arguments]...
launch() {
	svcuser="$1"
	shift 1
	exec gosu "$svcuser" tini -- "$@"
}

# Start the main app
launch app python app.py
