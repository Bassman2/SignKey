# SignKey
Creates a strong name sign key file from secrets

# Example

    - name: Add SignKeys
      uses: Bassman2/SignKey@v1
      with:
        file: Bassman.snk
        key: ${{ secrets.SIGNKEY }}
