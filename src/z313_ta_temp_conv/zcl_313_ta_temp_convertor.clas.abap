class zcl_313_ta_temp_convertor definition
  public
  create public .

  public section.
    methods celsius2fahrenheit
      importing i_temperature        type decfloat16
      returning value(r_temperature) type decfloat16
      raising   cx_invalid_argument.
    methods celsius2kelvin
      importing i_temperature        type decfloat16
      returning value(r_temperature) type decfloat16
      raising   cx_invalid_argument.
    methods fahrenheit2celsius
      importing i_temperature        type decfloat16
      returning value(r_temperature) type decfloat16
      raising   cx_invalid_argument.
    methods fahrenheit2kelvin
      importing i_temperature        type decfloat16
      returning value(r_temperature) type decfloat16
      raising   cx_invalid_argument.
    methods kelvin2celsius
      importing i_temperature        type decfloat16
      returning value(r_temperature) type decfloat16
      raising   cx_invalid_argument.
    methods kelvin2fahrenheit
      importing i_temperature        type decfloat16
      returning value(r_temperature) type decfloat16
      raising   cx_invalid_argument.

  private section.
    methods check_validity_kelvin
      importing i_temperature type decfloat16
      raising   cx_invalid_argument.
    methods check_validity_celsius
      importing i_temperature type decfloat16
      raising   cx_invalid_argument.
    methods check_validity_fahrenheit
      importing i_temperature type decfloat16
      raising   cx_invalid_argument.

endclass.



class zcl_313_ta_temp_convertor implementation.

  method celsius2fahrenheit.
    me->check_validity_celsius( i_temperature ).
    r_temperature = round(
      val = i_temperature * 9 / 5 + 32
      dec = 3 ).
  endmethod.

  method celsius2kelvin.
    me->check_validity_celsius( i_temperature ).
    r_temperature = round(
      val = i_temperature + '273.15'
      dec = 3 ).
  endmethod.

  method fahrenheit2celsius.
    me->check_validity_fahrenheit( i_temperature ).
    r_temperature = round(
      val = ( i_temperature - 32 ) * 5 / 9
      dec = 3 ).
  endmethod.

  method fahrenheit2kelvin.
    me->check_validity_fahrenheit( i_temperature ).
    r_temperature = round(
      val = ( i_temperature + '459.67' ) * 5 / 9
      dec = 3 ).
  endmethod.

  method kelvin2celsius.
    me->check_validity_kelvin( i_temperature ).
    r_temperature = round(
      val = i_temperature - '273.15'
      dec = 3 ).
  endmethod.

  method kelvin2fahrenheit.
    me->check_validity_kelvin( i_temperature ).
    r_temperature = round(
      val = i_temperature * 9 / 5 - '459.67'
      dec = 3 ).
  endmethod.

  method check_validity_kelvin.
    if i_temperature < 0 or i_temperature > 16000000.
      raise exception type cx_invalid_argument.
    endif.
  endmethod.

  method check_validity_celsius.
    if i_temperature < '-273.15' or i_temperature > '15999726.85'.
      raise exception type cx_invalid_argument.
    endif.
  endmethod.

  method check_validity_fahrenheit.
    if i_temperature < '-459.67' or i_temperature > '28799540.33'.
      raise exception type cx_invalid_argument.
    endif.
  endmethod.

endclass.
