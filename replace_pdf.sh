declare -A form_fields
timestamp=$(date +%s)
form_fields=(["FECHA"]="test")
pdftk $2.pdf generate_fdf output ${timestamp}_$1_tmp.fdf
for form_field in "${!form_fields[@]}";
    do cat ${timestamp}_$1_tmp.fdf | tr '\n' '\r' | sed "s/()\r\/T ($form_field)/(${form_fields[$form_field]})\r\/T ($form_field)/g" | tr '\r' '\n' > ${timestamp}_$1.fdf;
done
rm ${timestamp}_$1_tmp.fdf
pdftk $2.pdf fill_form ${timestamp}_$1.fdf output $3_${timestamp}_$1.pdf
rm ${timestamp}_$1.fdf