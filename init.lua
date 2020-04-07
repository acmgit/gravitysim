--gravitysim   made by Gundul no copyright nothing, do what you want with it
--
-- do not expect realism here. This is just for fun. So try out any values you like
-- and which suit your needs :)
-- 
-- have fun



local timer = 0
local checktime = 5 -- postion check intervall
local gravity = 1 -- standard on earth 9,81 m/s*s on sea level that is equal with 1 in Minetest game
local maxheight = 2500
local height = 3000

minetest.register_globalstep(function(dtime)

    timer = timer + dtime;
    if timer >= checktime then

        -- check all player altitudes and set new gravity
        local players = minetest.get_connected_players();

        for _,player in pairs(players) do
            local pos = player:getpos(); -- feet position
            local y=pos.y;               -- we only need the y ccordinate

            if y ~= nil then
                local newgrav=1;
                local newjump=1;

                if y >= 0 then

                    if(y >= maxheight) then y = maxheight end
                    newgrav = gravity - (y/height);    -- going up in the sky just try out some values to suit your needs
                    newjump = 1 + y/125,             -- jumping calculation

                    player:set_physics_override({gravity = newgrav,jump = newjump });

                else
                    -- commented out because if cannot even jump one node high its pretty useless to jump at all :)
                    -- newgrav = gravity - (y/32000);    -- going to the center of earth
                    -- newjump = 1 + y/10000             -- jumping should get lower the deeper you are

                    -- player:set_physics_override({gravity = newgrav,jump = newjump });
                end
                -- minetest.chat_send_all("I come and get your y position :) y-pos = ".. y .. " newgravity is : ".. newgrav) -- commend this out for ingame debug
            else
            --minetest.chat_send_all("something went wrong") -- commend this out for ingame debug

            end
        end

       timer =0

    end

end)

