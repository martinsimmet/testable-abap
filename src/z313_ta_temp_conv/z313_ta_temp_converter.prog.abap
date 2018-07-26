*&---------------------------------------------------------------------*
*& Report z313_ta_temp_converter
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report z313_ta_temp_converter.

parameters:
  temp type decfloat16 default '20.0e0'.

cl_demo_output=>display_data(
  exporting
    value = new zcl_313_ta_temp_convertor( )->zif_313_ta_temp_convertor~celsius2fahrenheit( i_source_value = temp ) ).
