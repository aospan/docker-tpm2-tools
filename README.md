# docker-tpm2-tools
# Latest tpm2-tools from https://github.com/tpm2-software/tpm2-tools/ build inside Docker container.

## How to build
```
docker build -t tpm2-tools .
```

## How to run

### Get TPM chip information:
```
docker run --privileged -it tpm2-tools tpm2_getcap properties-fixed
```

Example output on my machine:
```
TPM2_PT_FAMILY_INDICATOR:
  raw: 0x322E3000
  value: "2.0"
TPM2_PT_LEVEL:
  raw: 0
TPM2_PT_REVISION:
  raw: 0x8A
  value: 1.38
TPM2_PT_DAY_OF_YEAR:
  raw: 0x12F
TPM2_PT_YEAR:
  raw: 0x7E3
TPM2_PT_MANUFACTURER:
  raw: 0x494E5443
  value: "INTC"
TPM2_PT_VENDOR_STRING_1:
  raw: 0x496E7465
  value: "Inte"
TPM2_PT_VENDOR_STRING_2:
  raw: 0x6C000000
  value: "l"
```

[Full log can be found here](tpm2_properties_fixed.txt)

### Get TPM measurements (PCR values history)
```
docker run --privileged -v /sys/kernel/security/:/sys/kernel/security/ -it aospan/tpm2-tools tpm2_eventlog /sys/kernel/security/tpm0/binary_bios_measurements > tpm2_eventlog_pcr.txt

```

Example output on my machine:
```
- EventNum: 107
  PCRIndex: 4
  EventType: EV_EFI_BOOT_SERVICES_APPLICATION
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: "3ba11d87f4450f0b92bd53676d88a3622220a7d53f0338bf387badc31cf3c025"
  EventSize: 32
  Event:
    ImageLocationInMemory: 0x630b70c0
    ImageLengthInMemory: 11543392
    ImageLinkTimeAddress: 0x0
    LengthOfDevicePath: 0
    DevicePath: ''
```

Only one event listed here for simplicity. [Full log can be found here](tpm2_eventlog_pcr.txt)
