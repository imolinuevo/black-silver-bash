# Black Silver 
This is a bash script for automatic PDF form field replacing.

## Args

1) **user:** single word username
2) **template:** full template url & filename without extension (must be *PDF*)
3) **output:** full output file location url & filename without extension (will be *PDF*)
4) **form_fields** serialized string containing the form fields key-values

## Example

```
bash replace_pdf.sh admin in/invoice_template out/invoice "FECHA-test TOTAL-100"
```