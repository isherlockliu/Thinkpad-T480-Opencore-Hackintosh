// Fixing / Adding various devices for macOS compatibility

/* 
 * ALS0
 * Fake Ambient Light Sensor Starting with Catalina, an ambient light sensor device is required for brightness preservation. This patch fakes an ambient light sensor device ALS0 since the x1c6 does not have one.
 * Why?: ACPI0008 missing in DSDT
 */

/* 
 * PWRB
 * Why?: PNP0C0C missing in DSDT.
 * Patch power button.
 */

/* MCHC-SBUS
   What is AppleSMBus? Well this mainly handles the System Management Bus, which has many functions like:

    AppleSMBusController
        Aids with correct temperature, fan, voltage, ICH, etc readings
    AppleSMBusPCI
        Same idea as AppleSMBusController except for low bandwidth PCI devices
    Memory Reporting
        Aids in proper memory reporting and can aid in getting better kernel panic details if memory related
 */

/* 
 * DMAC
 * Patch Memory Controller 
 * Why?: PNP0200 is missing in DSDT.
 */


DefinitionBlock ("", "SSDT", 2, "T480", "Missing", 0)
{
    // Common utils from SSDT-Utils
    External (OSDW, MethodObj)
    
    External (\_SB.PCI0, DeviceObj)
    External (\_SB.PCI0.SBUS, DeviceObj)
    External (\_SB.PCI0.LPCB, DeviceObj)
    
    Scope (\_SB)
    {
        Device (ALS0)
        {
            Name (_HID, "ACPI0008" /* Ambient Light Sensor Device */)  // _HID: Hardware ID
            Name (_CID, "smc-als")  // _CID: Compatible ID
            Name (_ALI, 0x012C)  // _ALI: Ambient Light Illuminance
            Name (_ALR, Package (0x01)  // _ALR: Ambient Light Response
            {
                Package (0x02)
                {
                    0x64, 
                    0x012C
                }
            })

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (OSDW ())
                {
                    Return (0x0B)  // ALS Enabled.  Don't show it in UI.
                }

                Return (Zero)
            }
        }
        
        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C") /* Power Button Device */)  // _HID: Hardware ID

            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                Return (Zero)
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (OSDW ())
                {
                    Return (0x0B)
                }

                Return (Zero)
            }
        }

        Scope (PCI0) 
        {
             Device (MCHC)
            {
                Name (_ADR, Zero)

                Method (_STA, 0, NotSerialized)
                {
                    If (OSDW ())
                    {
                        Return (0x0F)
                    }
                    
                    Return (Zero)
                }
            }
            
            Scope (SBUS)
            {
                Device (BUS0)
                {
                    Name (_CID, "smbus")  // _CID: Compatible ID
                    Name (_ADR, Zero)  // _ADR: Address

                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (OSDW ())
                        {
                            Return (0x0F)
                        }

                        Return (Zero)
                    }
                }

                Device (BUS1)
                {
                    Name (_CID, "smbus")  // _CID: Compatible ID
                    Name (_ADR, One)  // _ADR: Address

                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (OSDW ())
                        {
                            Return (0x0F)
                        }

                        Return (Zero)
                    }
                }                
            }
        
            Scope (LPCB)
            {
                Device (DMAC)
                {
                    Name (_HID, EISAID("PNP0200"))

                    Name (_CRS, ResourceTemplate()
                    {
                        IO (Decode16, 0x00, 0x00, 0x01, 0x20)
                        IO (Decode16, 0x81, 0x81, 0x01, 0x11)
                        IO (Decode16, 0x93, 0x93, 0x01, 0x0d)
                        IO (Decode16, 0xc0, 0xc0, 0x01, 0x20)
                        DMA (Compatibility, NotBusMaster, Transfer8_16) { 4 }
                    })

                    Method (_STA, 0, NotSerialized)
                    {
                        If (OSDW ())
                        {
                            Return (0x0F)
                        }

                        Return (Zero)
                    }
                }   
            }
        }   
    }
}
