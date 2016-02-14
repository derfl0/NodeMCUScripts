function transmit(temp)
    --setup connection
    conn=net.createConnection(net.TCP, 0)
    
    -- callback after receive
    conn:on("receive", function(conn, payload) 
        print(payload)
        conn:close()
        --mysleep()
    end)
    
    -- callback when connection stands
    conn:on("connection",function(conn, payload)
        local payload = "GET /mySecretPath?"..temp.." HTTP/1.1\r\nHost: myhost.com\r\n"
        .. "Connection:close\r\nAccept: */*\r\n\r\n"
        print(payload)
        conn:send(payload)
    end)
    
    -- dns and connect
    conn:dns('fl0.eu',function(conn,ip)
        conn:connect(80, ip)
    end)
end
