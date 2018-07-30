*"* use this source file for your ABAP unit test classes
class ltc_boundary_value_analysis definition
  for testing
  risk level harmless "unit test execution does no harm to the system
  duration short. "unit test execution does not put load on the system

  private section.
    types:
      begin of df16_line_t,
        kelvin     type decfloat16,
        celsius    type decfloat16,
        fahrenheit type decfloat16,
      end of df16_line_t,
      df16_tab_t type standard table of df16_line_t with default key.

    " CUT: Code Under Test
    data m_cut type ref to zcl_313_ta_temp_convertor.

    " 'Infrastructure' methods called by ABAP Unit framework
    methods setup.  "called before each "for testing" method

    " Test Methods called from ABAP Unit framework
    methods kelvin for testing.
    methods celsius for testing.
    methods farenheit for testing.

    " methods that help structuring and organizing code
    methods kelvin_valid importing i_data_tab type df16_tab_t.
    methods kelvin_invalid importing i_data_tab type df16_tab_t.
    methods celsius_valid importing i_data_tab type df16_tab_t.
    methods celsius_invalid importing i_data_tab type df16_tab_t.
    methods farenheit_valid importing i_data_tab type df16_tab_t.
    methods farenheit_invalid importing i_data_tab type df16_tab_t.

endclass.

class ltc_boundary_value_analysis implementation.

  method setup.
    m_cut = new zcl_313_ta_temp_convertor( ).
  endmethod.

  method kelvin_invalid.
    loop at i_data_tab assigning field-symbol(<data>).
      "k2c
      try.
          m_cut->kelvin2celsius( <data>-kelvin ).
          cl_abap_unit_assert=>fail( ).
        catch cx_invalid_argument.
          ##no_handler
      endtry.
      "k2f
      try.
          m_cut->kelvin2fahrenheit( <data>-kelvin ).
          cl_abap_unit_assert=>fail( ).
        catch cx_invalid_argument into data(cx_k2f).
          ##no_handler
      endtry.
    endloop.
  endmethod.

  method kelvin_valid.
    loop at i_data_tab assigning field-symbol(<data>).
      "k2c
      cl_abap_unit_assert=>assert_equals(
        exp = <data>-celsius
        act = m_cut->kelvin2celsius( <data>-kelvin )
        msg = |Kelvin ({ <data>-kelvin }) Celsius ({ <data>-celsius })| ).
      "k2f
      cl_abap_unit_assert=>assert_equals(
        exp = <data>-fahrenheit
        act = m_cut->kelvin2fahrenheit( <data>-kelvin ) ).
    endloop.
  endmethod.

  method celsius_invalid.
    loop at i_data_tab assigning field-symbol(<data>).
      "c2k
      try.
          m_cut->celsius2kelvin( <data>-celsius ).
          cl_abap_unit_assert=>fail( ).
        catch cx_invalid_argument.
          ##no_handler
      endtry.
      "c2f
      try.
          m_cut->celsius2fahrenheit( <data>-celsius ).
          cl_abap_unit_assert=>fail( ).
        catch cx_invalid_argument into data(cx_c2f).
          ##no_handler
      endtry.
    endloop.
  endmethod.

  method celsius_valid.
    loop at i_data_tab assigning field-symbol(<data>).
      "c2k
      cl_abap_unit_assert=>assert_equals(
        exp = <data>-kelvin
        act = m_cut->celsius2kelvin( <data>-celsius )
        msg = |Celsius ({ <data>-celsius }) Kelvin ({ <data>-kelvin })| ).
      "c2f
      cl_abap_unit_assert=>assert_equals(
        exp = <data>-fahrenheit
        act = m_cut->celsius2fahrenheit( <data>-celsius )
        msg = |Celsius({ <data>-celsius }) Fahrenheit({ <data>-fahrenheit })| ).
    endloop.
  endmethod.

  method farenheit_invalid.
    loop at i_data_tab assigning field-symbol(<data>).
      "f2k
      try.
          m_cut->fahrenheit2kelvin( <data>-fahrenheit ).
          cl_abap_unit_assert=>fail( ).
        catch cx_invalid_argument into data(cx_f2k).
          ##no_handler
      endtry.
      "f2c
      try.
          m_cut->fahrenheit2celsius( <data>-fahrenheit ).
          cl_abap_unit_assert=>fail( ).
        catch cx_invalid_argument into data(cx_f2c).
          ##no_handler
      endtry.
    endloop.
  endmethod.

  method farenheit_valid.
    loop at i_data_tab assigning field-symbol(<data>).
      "f2k
      cl_abap_unit_assert=>assert_equals(
        exp = <data>-kelvin
        act = m_cut->fahrenheit2kelvin( <data>-fahrenheit )
        msg = |Farenheit ({ <data>-fahrenheit }) Kelvin ({ <data>-kelvin })| ).
      "f2c
      cl_abap_unit_assert=>assert_equals(
        exp = <data>-celsius
        act = m_cut->fahrenheit2celsius( <data>-fahrenheit )
        msg = |Fahrenheit({ <data>-fahrenheit }) Celsius({ <data>-celsius })| ).
    endloop.
  endmethod.

  method kelvin.

    data(data_valid) = value df16_tab_t( (
        kelvin     = 0                  "Test case 01
        celsius    = '-273.15'
        fahrenheit = '-459.67' ) (
        kelvin     = 16000000           "Test case 02
        celsius    = '15999726.85'
        fahrenheit = '28799540.33' ) ).
    me->kelvin_valid( data_valid ).

    data(data_invalid) = value df16_tab_t( (
      kelvin = '-0.01' ) (              "Test case 03
      kelvin = '16000000.01' ) ).       "Test case 04
    me->kelvin_invalid( data_invalid ).

  endmethod.

  method celsius.

    data(data_valid) = value df16_tab_t( (
      celsius = '-273.15'               "Test case 05
      kelvin = 0
      fahrenheit = '-459.67' ) (
      celsius = '-0.01'                 "Test case 06
      kelvin = '273.14'
      fahrenheit = '31.982' ) (
      celsius = 0                       "Test case 07
      kelvin = '273.15'
      fahrenheit = 32 ) (
      celsius = '15999726.85'           "Test case 08
      kelvin = 16000000
      fahrenheit = '28799540.33' ) ).
    me->celsius_valid( data_valid ).

    data(data_invalid) = value df16_tab_t( (
      celsius = '-273.16' ) (           "Test case 09
      celsius = '15999726.86' ) ).      "Test case 10
    me->celsius_invalid( data_invalid ).

  endmethod.

  method farenheit.

    data(data_valid) = value df16_tab_t( (
      fahrenheit = '-459.67'            "Test case 11
      kelvin = 0
      celsius = '-273.15' ) (
      fahrenheit = '-0.01'              "Test case 12
      kelvin = '255.367'
      celsius = '-17.783' ) (
      fahrenheit = 0                    "Test case 13
      kelvin = '255.372'
      celsius = '-17.778' ) (
      fahrenheit = '28799540.33'        "Test case 14
      kelvin = 16000000
      celsius = '15999726.85' ) ).
    me->farenheit_valid( data_valid ).

    data(data_invalid) = value df16_tab_t( (
      fahrenheit = '-459.68' ) (        "Test case 15
      fahrenheit = '28799540.34' ) ).   "Test case 16
    me->farenheit_invalid( data_invalid ).

  endmethod.

endclass.
