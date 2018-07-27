class zcl_313_ta_temp_convertor definition
  public
  create public .

  public section.
    methods celsius2fahrenheit
      importing i_temperature        type decfloat16
      returning value(r_temperature) type decfloat16.
    methods celsius2kelvin
      importing i_temperature        type decfloat16
      returning value(r_temperature) type decfloat16.
    methods fahrenheit2celsius
      importing i_temperature        type decfloat16
      returning value(r_temperature) type decfloat16.
    methods fahrenheit2kelvin
      importing i_temperature        type decfloat16
      returning value(r_temperature) type decfloat16.
    methods kelvin2celsius
      importing i_temperature        type decfloat16
      returning value(r_temperature) type decfloat16.
    methods kelvin2fahrenheit
      importing i_temperature        type decfloat16
      returning value(r_temperature) type decfloat16.

endclass.



class zcl_313_ta_temp_convertor implementation.

  method celsius2fahrenheit.

  endmethod.

  method celsius2kelvin.

  endmethod.

  method fahrenheit2celsius.

  endmethod.

  method fahrenheit2kelvin.

  endmethod.

  method kelvin2celsius.

  endmethod.

  method kelvin2fahrenheit.

  endmethod.

endclass.
