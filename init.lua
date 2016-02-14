--start wifi initiator
dofile("wifi.lua")
dofile("temp.lua")
--dofile("logger.lua")
dofile("transmit.lua")

--dummy get temp to prevent first 85 degree
getTemp(3)

tmr.alarm(0,60000,1,function()
    transmit("temp[]="..getTemp(3))
end)

function mysleep()
    local night = 60000000 - tmr.now()
    node.dsleep(night)
end
