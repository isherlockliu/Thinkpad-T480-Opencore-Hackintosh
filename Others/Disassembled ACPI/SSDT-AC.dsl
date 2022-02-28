/* Patching AC-Device so that AppleACPIACAdapter-driver loads.
 * Device named ADP1 on Mac
 * See https://github.com/khronokernel/DarwinDumped/blob/b6d91cf4a5bdf1d4860add87cf6464839b92d5bb/MacBookPro/MacBookPro14%2C1/ACPI%20Tables/DSL/DSDT.dsl#L7965
 */

DefinitionBlock ("", "SSDT", 2, "T480", "AC", 0x00001000)
{
    // Common utils from SSDT-Utils
    External (OSDW, MethodObj) // 0 Arguments

    External (_SB.PCI0.LPCB.EC.AC, DeviceObj)
    External (LWCP, FieldUnitObj) // LID control power

    Scope (\_SB.PCI0.LPCB.EC.AC)
    {
        Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
        {
            If (\OSDW () || \LWCP)
            {
                Return (Package (0x02)
                {
                    0x17, 
                    0x04
                })
            }

            Return (Package (0x02)
            {
                0x17, 
                0x03
            })
        }
    }
}
// EOF
