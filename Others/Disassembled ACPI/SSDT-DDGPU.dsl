DefinitionBlock("", "SSDT", 2, "T480", "DDGPU", 0x00001000)
{
    // Common utils from SSDT-Utils
    External (OSDW, MethodObj) // 0 Arguments    
    
    External (_SB.PCI0, DeviceObj)
    External (_SB.PCI0.RP01, DeviceObj)
    External (_SB.PCI0.HGOF, MethodObj)    // 0 Arguments
    External (P8XH, MethodObj)    // 2 Arguments
    External (_SB.PCI0.RP01.VDID, FieldUnitObj)
    External (_SB.PCI0.RP01.LDIS, FieldUnitObj)
    External (_SB.PCI0.LPCB.DGRT, IntObj)
    External (_SB.PCI0.LPCB.DGON, IntObj)

     // Disable MX150 on PCIe-Level
    Scope (_SB.PCI0.RP01)
    {
        Method (DOFF, 0, Serialized)
        {
            Debug = "Disable MX150..."
            // Debug = "Disable MX150: VDID: (before)"
            // Debug = VDID

            // Disable MX150
            \P8XH (Zero, 0x21)
            ^^HGOF ()
            \P8XH (Zero, 0x22)

            // disable rp01-pci-bridge
            ^^LPCB.DGRT = Zero
            ^^LPCB.DGON = Zero
            LDIS = One

            // Debug = "Disable MX150: DGRT: (after)"
            // Debug = ^^LPCB.DGRT

            // Debug = "Disable MX150: DGON: (after)"
            // Debug = ^^LPCB.DGON

            // Debug = "Disable MX150: VDID: (after)"
            // Debug = VDID
        }

        Method (_STA, 0, Serialized)
        {
            // Debug = "Disable MX150: _STA"

            If (OSDW ())
            {
                DOFF ()

                Return (Zero)
            }

            Return (0x0F)
        }

        Method (_PS0, 0, Serialized)
        {
            // Debug = "Disable MX150: _PS0"

            If (OSDW ())
            {
                DOFF ()
            }
        }

        Method (_PS3, 0, Serialized)
        {
            // Debug = "Disable MX150: _PS3"

            If (OSDW ())
            {
                DOFF ()
            }
        }
    }
}
// EOF
