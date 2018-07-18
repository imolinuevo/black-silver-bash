declare -A form_fields

arr=( $4 )
for i in "${arr[@]}";
    do
        key=$(echo $i | cut -f1 -d-)
        value=$(echo $i | cut -f2 -d-)
        form_fields["$key"]="$value"
        echo $key $value
done

timestamp=$(date +%s)
pdftk $2.pdf generate_fdf output ${timestamp}_$1_tmp.fdf
for form_field in "${!form_fields[@]}";
    do
        cat ${timestamp}_$1_tmp.fdf | tr '\n' '\r' | sed "s/()\r\/T ($form_field)/(${form_fields[$form_field]})\r\/T ($form_field)/g" | tr '\r' '\n' > ${timestamp}_$1.fdf;
        cat ${timestamp}_$1.fdf > ${timestamp}_$1_tmp.fdf
done
rm ${timestamp}_$1_tmp.fdf
pdftk $2.pdf fill_form ${timestamp}_$1.fdf output $3_${timestamp}_$1.pdf
rm ${timestamp}_$1.fdf