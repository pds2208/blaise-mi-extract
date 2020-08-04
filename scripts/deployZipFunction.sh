#!/bin/bash

gcloud config set functions/region europe-west2

gcloud functions deploy ZipFunction --runtime go113 --trigger-resource ons-blaise-dev-pds-20-mi-zip \
  --trigger-event google.storage.object.finalize \
  --set-env-vars "DEBUG=True" \
  --set-env-vars "ZIP_LOCATION=ons-blaise-dev-pds-20-mi-zip" \
  --set-env-vars "ENCRYPTED_LOCATION=ons-blaise-dev-pds-20-mi-encrypted" \
  --set-env-vars "PUBLIC_KEY=pkg/encryption/keys/preprod-key.gpg" \
  --set-env-vars "ENCRYPT_LOCATION=ons-blaise-dev-pds-20-mi-encrypt"

gcloud alpha functions add-iam-policy-binding ZipFunction --member=allUsers --role=roles/cloudfunctions.invoker