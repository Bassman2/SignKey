# SignKey
Creates a strong name sign key file from secrets

# Example
## Convert sign key to base64
### Windows

### Linux
base64 signkey.snk > signkey.b64
### macOS
base64 -i signkey.snk -o signkey.b64

## Add base64 encoded signkey to repository
* Goto Settings / Secrets and variables / Actions
* Press "New repository secrets"
* Name: "SIGNKEY"
* Secret: text of signkey.b64 file
* Press "Add secret"

## Github Action

jobs:
  build:
    environment: sign

    steps:
    - name: Add SignKeys
      uses: Bassman2/SignKey@v1
      with:
        file: Bassman.snk
        key: ${{ secrets.SIGNKEY }}
