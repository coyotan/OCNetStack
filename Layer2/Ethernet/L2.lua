--[[
DESCRIPTION: This is an implementation of the standard defined by OETF #7, available at https://oc.cil.li/topic/1175-oetf-7-on2-simple-l2-protocol-for-network-stacks/
AUTHOR: COYOTAN#0962
MAINTAINER: COYOTAN#0926
]]
local component = require("component")
local vcomp = require("vcomponent")
local event = require("event")
local uuid = require("uuid")

if component.isAvailable("modem") and component.modem.isWired() then
    local modem = component.modem
else
    --Throw error; A wired modem is not present. This library can only be used with a wired modem.
end


--[[
    Library Configuration information
    Please be aware that changing these values may prevent host discovery, automatic configuration, and network communication if they are made without awareness to their meaning.
    Please see the documentation for this implementation if you are unclear on what these configuration values do.
]]
local defaultVLAN = 1

--[[
    Protocol Identification
    In this section the possible values of the protocol header are defined.
]]
local OCHD = 0x0c --OC Host Discovery
local IPF  = 0x46 --IP 4/6 Frames 
local OHCP = 0xCF -- Open Host Configuration Protocol
local MICE = 0x1000 --MultiICE protocol
local UDF  = 0xFFFF -- Anything above this value is user defined.

--[[
    Runtime variables
    Library values are identified in this section. If your intentions are to configure this implementation, this is NOT the place to do so.
]]
local componentProxy = {}
local componentDocs = {}
local subscribedVLANs = {}

--[[
    Library Methods
]]
local function tableHasValue(table,value) 
    for i, v in ipairs(table) do 
        if v = value then
            return true
        end
    end

    return false
end

-- Add a VLAN to our listening list.
local function subscribeToVLAN(vlan)
    if tableHasValue(subscribedVLANs, vlan)
        if !modem.isOpen(vlan) then 
            modem.open(vlan)
        end
        return true
    else 
        table.insert(subscribedVLANs, vlan)
        modem.open(vlan)
        return true
    end
end

--[[
    Component Function and Method Declarations
]]
    --This function is for defining a simple send function.
    componentDocs.send = "function(address:string, vlan:nil or int, proto:int, data:value) -- sends the provided data to the address. If no VLAN is specified, default vlan is used."    
    componentProxy.send = function(dest, vlan, proto, data)
        vlan = defaultVLAN or vlan
        component.invoke(modem,"send",dest, vlan, proto, data)
    end

    --This function implements an "untagged" VLAN feature.
    componentDocs.setDefaultVLAN = "function(vlan:number):bool -- Sets the default VLAN to the provided value."
    componentProxy.setDefaultVLAN = function(vlan) 
        if type(vlan) == "number" then 
            defaultVLAN = vlan
            return true
        else
            --error
        end
    end

    --This function implements the ability to subscribe to multiple VLANs 
    componentDocs.subscribeToVLAN = "function(vlan:number):bool -- Creates a new VLAN interface and subscribes to it."
    
--[[
    REGISTRATION/FINALIZATION
]]
subscribeToVLAN(defualtVLAN)
modem.open(defaultVLAN)

--This should be one of the last lines
vcomp.register(uuid.next(),"ethernet",componentProxy, componentDocs)
