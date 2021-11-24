# <p align=center> Layer 2 Host Discovery Protocol
<div align=center>

| Author | Maintainer | For |
| --- | --- | --- | 
| Coyotan | Coyotan | L2HD |

</div>

## <p align=center> Description
---
The Layer 2 Host Discovery Protocol is a component of the OCNetStack whch follows the definitions provided by OETF #9 - OC Host Discovery Protocol for OETF #7. The purpose of this utility is to establish an implementation of OETF #7 to support the Layer 3 components of OCNetStack. 
<br>
<br>
## L2HD Interface
L2HD is a protocol which relies on L2/Ethernet and retrieves layer 3 information to evaluate how packets should be routed. L2HD exists to provide local area network information, including connected hosts. L2HD is a wireless and wired compatible protocol.

## Features Implemented By This Framework
### 1) Uses L2 Ethernet to Send and Receive LAN Information
- In compliance with OETF #7 and OETF #9, L2HD uses L2/Ethernet, or a compliant wireless protocol[UNIMPLEMENTED] to communicate information to immediately connected nodes.
- An example of where this protocol may be useful is when attempting to determine if a layer 2 host is available on a network connection, or if more than one host is available on a network connection.

### 2) An Address Table, Necessary to the Implementation of Multi-Interface Communication
- Layer 3 addresses must be resolvable by layer 2, so that it may be possible to determine the route to send packets towards. This implementation will provide an ARP table and the methods required to access and maintain the entries therein.

## 3) Methods Implemented by This Library
- Resolutions():array[string=string]
  - A total list of all addresses in the in the address table.
  - Note: The address table is also provided as a result when the "host_discovered" event is fired.
- DiscoveryRequest()
  - According to OETF #7, this sends a Layer 2 Broadcast to all nodes available on the local network.
- DiscoveryResponse(address:string)
  - A single packet will be sent directly to the requestor per each layer 3 address assigned to the L2 interface.
- DumpTable():boolean
  - Causes the address table to be dumped immediately.
  - This will fire an event, "address_purge".
  - Dumping the address table will not dump cached tables. If a program which caches address entries does not listen for the purge event, it may result in the use of outdated entries.