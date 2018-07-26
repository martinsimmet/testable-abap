interface zif_313_ta_temp_convertor
  public.

  methods:
    celsius2fahrenheit
      importing i_source_value        type decfloat16
      returning value(r_target_value) type decfloat16,
    fahrenheit2celsius
      importing i_source_value        type decfloat16
      returning value(r_target_value) type decfloat16,
    celsius2kelvin
      importing i_source_value        type decfloat16
      returning value(r_target_value) type decfloat16,
    kelvin2celsius
      importing i_source_value        type decfloat16
      returning value(r_target_value) type decfloat16,
    kelvin2fahrenheit
      importing i_source_value        type decfloat16
      returning value(r_target_value) type decfloat16,
    fahrenheit2kelvin
      importing i_source_value        type decfloat16
      returning value(r_target_value) type decfloat16.

endinterface.
