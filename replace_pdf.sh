declare -A form_fields
form_fields=(["FECHA"]="test")
pdftk invoice_template.pdf generate_fdf output invoice_tmp.fdf
for form_field in "${!form_fields[@]}";
    do cat invoice_tmp.fdf | tr '\n' '\r' | sed "s/()\r\/T ($form_field)/(${form_fields[$form_field]})\r\/T ($form_field)/g" | tr '\r' '\n' > invoice.fdf;
done
rm invoice_tmp.fdf
pdftk invoice_template.pdf fill_form invoice.fdf output filled.pdf