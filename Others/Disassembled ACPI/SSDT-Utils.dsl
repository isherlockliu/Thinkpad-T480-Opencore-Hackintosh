/*
 * Detect Darwin (OSX) to enable other patches
 * Credits @osy86
 */

DefinitionBlock ("", "SSDT", 2, "T480", "Utils", 0)
{
    Method (DTGP, 5, NotSerialized)
    {
        If ((Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b")))
        {
            If ((Arg1 == One))
            {
                If ((Arg2 == Zero))
                {
                    Arg4 = Buffer (One)
                        {
                             0x03
                        }
                    Return (One)
                }

                If ((Arg2 == One))
                {
                    Return (One)
                }
            }
        }

        Arg4 = Buffer (One)
            {
                 0x00
            }
        Return (Zero)
    }

    Scope (\)
    {
        Method (OSDW, 0, NotSerialized)
        {
//            Warnings: Method Local is set but never used ()
//            If (CondRefOf (\_OSI, Local0))
            If (CondRefOf (\_OSI))
            {
                If (_OSI ("Darwin"))
                {
                    Return (One) // is Darwin
                }
            }
            Return (Zero)
        }
    }
}