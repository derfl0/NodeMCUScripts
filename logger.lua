-- write file to log
function log(temp)
    print("Log: "..temp)
    file.open("log", 'a+')
    file.writeline(temp)
    file.close()
    counter()
end

-- counter
function counter()
    local threshold = 4
    dofile("counter.lua")
    print("Loading counter "..count)
    local transmission = ""
    if count > threshold then
        print("Transmit")
        file.open("log", 'r')
        repeat _line = file.readline() 
        if (_line~=nil) then 
            transmission = transmission .. "temp[]="..(string.sub(_line,1,-2)) .. "&" 
        end
        until _line==nil 
        file.close()
        count = 0

        --start wifi
        dofile("wifi.lua")
        dofile("transmit.lua")
        tmr.alarm(1, 1000, 8, function()
            if (wifi.sta.getip()) ~= nil then
                tmr.stop(1)
                transmit(transmission)
                file.remove("log")
                writeCounter()
            end
        end)
    else
        count = count + 1
        writeCounter()
    end
end

function writeCounter()
    file.remove("counter.lua")
    file.open("counter.lua", 'w+')
    file.writeline("count = "..count)
    file.close()
end
