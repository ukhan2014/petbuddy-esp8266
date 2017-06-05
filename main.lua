-- main.lua --

function setupAP()
   print("Setting up AP...")
   
   -- Network Variables
   ap_cfg = 
   {
      ssid = "PB053117104000",
      pwd = "053117104000"
   }

   ip_cfg = 
   {
      ip = "192.168.1.1",
      netmask = "255.255.255.0",
      gateway = "192.168.1.1"
   }

   -- Configure Wireless Internet
   wifi.setmode(wifi.SOFTAP)
   print('set mode=SOFTAP (mode='..wifi.getmode()..')\n')
   print('MAC Address: ',wifi.sta.getmac())
   print('Chip ID: ',node.chipid())
   print('Heap Size: ',node.heap(),'\n')

   -- Configure WiFi
   wifi.ap.config(ap_cfg)
   wifi.ap.setip(ip_cfg)
end

function waitForClients()
   print("Waiting for clients")
   
   tmr.alarm( 0, 1000, 1, function()
      --if wifi.sta.getip() == nil then
      --   print("Connecting to AP...\n")
      table = {}
      table = wifi.ap.getclient()
      if next(table) == nil then
         print("No cnxn for PBD setup...")
      else
         ip, nm, gw=wifi.ap.getip()
         print("IP Info: \nIP Address: ",ip)
         print("Netmask: ",nm)
         print("Gateway Addr: ",gw,'\n')
         print("Current list of clients:\n")
         for mac, ip in pairs(table) do
            print(mac,ip)
         end
         tmr.stop(0)
      end
   end) 
end

-- connects to a user's home WiFi network
-- Takes a config structure:
-- ap_cfg = 
-- {
--    ssid = "XXXXXXX...",
--    pass = "XXXXXXX..."
-- }
function connectWifi(cfg)

end


function beginServer()

end

function beginExistingSession()

end  

----------------------------------
--       main() function        --
----------------------------------
print("main()")

setupAP()
   
if(file.exists("env.cfg")) then
   beginExistingSession()
else
   print("no env file, start cfg")
   waitForClients()
end
