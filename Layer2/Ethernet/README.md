# <p align=center> Ethernet for OCNetStack

| Author | Maintainer | For |
| --- | --- | --- | 
| Coyotan | Coyotan | Ethernet |
| Gamax92 | Gamax92 | vComponent|

## <p align=center> Description
---
The Ethernet component of the OCNetStack follows the definitions provided by the OETF #7 - ON2 - OCNet L2 Protocol For Network Stacks. The purpose of this utility is to establish a framework for standardized communication. This document will outline the Wills and Will Nots of what this implementation will accomplish.
<br>
<br>
## Ethernet Interface
A primary concern of this framework is its ease of use and implementation. The Ethernet framework uses the vComponent Library from Gamax92 will provide a virtual component interface with the ability to control most of the methods and configurations needed to configure local area networks.

## Features Implemented By This Framework
### 1) A Standard Interface For Layer 2 Interactions
- Ethernet will provide a standard-compliant interface to communicate using Layer 2 protocols such as Open Host Configuration and Open Host Discovery Protocol. 
### 2) An Address Table, Necessary to the Implementation of Multi-Interface Communication
- Ethernet is designed to support network segmentation. Network gateways will require packet-based routing. For efficient use, it will be required to maintain a small list of hosts immediately available on specific interfaces.
- This feature is only needed on routing and switching devices. A configuration option will be available to enable this functionality, which is disabled by default.
### 3) Interface Methods
- State(string): string
  - The following states are available:
    - Up
    - Down
    - Admin_down
  - If an argument is not passed this function will return the current state.
  - If an argument is passed this function will return the assigned state.
- Send()
- Receive
- Broadcast
- DefaultVLAN : Returns boolean
  - If no value is provided this returns the current VLAN. 
  - If a VLAN is provided, it will become the new Default VLAN. This is equivlant to the 802.1Qs use of Untagged VLANs.
- SubscribeToVLAN : String
  - If a node needs access to multiple VLANs, a virtual component can be easily created to send and receive on this port.
- UnsubscribeToVLAN : Boolean
  - When a node no longer needs to listen for traffic on a VLAN it may unregister its handler and destroy the virtual interface.