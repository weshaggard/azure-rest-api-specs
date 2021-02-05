These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
# add any configuration here for all CLI languages
# refer to the faq.md for more details


cli:
  cli-name: codesigning
  package-name: azure-mgmt-codesigning
  namespace: azure.mgmt.codesigning
  test-scenario:
    - name: Create Code Sign Account
    - name: Get Code Sign Account
    - name: Update Code Sign Account
    - name: Delete Code Sign Account

```