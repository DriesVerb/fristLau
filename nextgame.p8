pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

-- 07:19

local player
local score
local coins

function _init()
    sfx(0)
    
    score=0
    -- player table = object
    player = {
        x=64,
        y=64,
        width=8,
        height=8,
        color=9,
        is_vertical_align=false,
        is_horizontal_align=false,
        name="jilles",
        move_speed=2,
        update=function(self)
            if btn(1)then
                self.x+=self.move_speed end
                if btn(0) then
                self.x-=self.move_speed end
                if btn(2) then
                self.y-=self.move_speed end
                if btn(3) then
                self.y+=self.move_speed end
        end,
        draw=function (self)
                spr(3, self.x, self.y)
                rect(self.x, self.y, self.x+self.width, self.y+self.height,3)

        end,
        check_for_coin_collision = function (self, coin)
                            
                -- local player_top = self.y
                -- local player_bottom = self.y+self.height
                -- local player_left=self.x
                -- local player_right=self.x+self.width
                -- local coin_top = coin.y
                -- local coin_bottom = coin.y+coin.height
                -- local coin_left=coin.x
                -- local coin_right=coin.x+coin.width

                -- if not coin.is_collected and circles_overlapping(self.x, self.y, self.radius, coin.x, coin.y, coin.radius)

                -- -- rect_overlapping(player_left, player_top, player_right, player_bottom, coin_left, coin_top, coin_right, coin_bottom) 
                
                -- then
                --     coin.is_collected=true
                --     score+=1
                -- end
                
        end
    }
    coins = {
        make_coin(10,10),
        make_coin(40,20),
        make_coin(90,70),
        make_coin(50,10),
        make_coin(80,90),
    }

    blocks={
        make_block(50,80),
        make_block(20,80),
    }

    

    
end

function _update()
    player:update()
    local coin
    for coin in all(coins) do 
        coin:update()
        player:check_for_coin_collision(coin)
    end
    local block
    for block in all(blocks) do 
        block:update()
    end

end

function _draw()
    cls()
    player:draw()
    print(score, 5, 5, 7)
    local coin
    for coin in all(coins) do 
        coin:draw()
    end
    local block
    for block in all(blocks) do 
        block:draw()
    end

end

function make_coin(x,y)
    local coin = {
        x=x,
        y=y,
        width=6,
        height=6,
        is_collected=false,
        update=function(self)
            
        end,
        draw=function(self)
            if not self.is_collected then 
                spr(4, self.x, self.y)
                rect(self.x, self.y, self.x+self.width, self.y+self.width)
            end
            
        end

    }
    return coin
end

function make_block(x,y)
    return {
        x=x,
        y=y,
        width=8,
        height=8,
        update=function(self)
            
        end,
        draw=function(self)
            spr(5, self.x, self.y)
            rect(self.x, self.y, self.x+self.width, self.y+self.height,8)
        end
        

    }
end


-- point is in rectangle collision
-- function is_point_in_rect(x , y, left, top, right, bottom)

--     return top<y and y<bottom and left<x and x<right
    
-- end

function lines_overlapping(min1, max1, min2, max2)

    return max1>min2 and max2>min1


    -- long version of above statement
    -- if right1>left2 and right2>left1 then
    --     return true
    -- else
    --     return false
    -- end 

    -- long version of above statement
    -- if left2<left1 and left1<left2 then
    --     return true
    -- elseif left2<right1 and right1<left2 then
    --     return true
    -- elseif left1<left2 and left2<righ1 then
    --     return true
    -- elseif left1<right2 and right2<right1 then
    --     return true
    -- else
    --     return false
    -- end

end

function rect_overlapping(left1, top1, right1, bottom1, left2, top2, right2, bottom2)

    return lines_overlapping(left1, right1, left2, right2) and lines_overlapping(top1, bottom1, top2, bottom2)

    -- long version of above statement
    -- if lines_overlapping(left1, right1, left2, right2) and lines_overlapping(top1, bottom1, top2, bottom2)
    --     return true
    -- else 
    --     return false
    -- end


end


-- detection for cirlces
-- function circles_overlapping(x1, y1, r1, x2, y2, r2)
--     local dx=mid(-100,x2-x1,100)
--     local dy=mid(-100,y2-y1,100)
--     return dx*dx+dy*dy<(r1+r2)*(r1+r2)


--     -- local dist=sqrt(dx*dx+dy*dy)
--     -- return dist<r1+r2


--     -- if dist<r1+r2 then
--     --     return true
--     -- else 
--     --     return false
--     -- end
-- end

function bouding_boxes_overlapping(obj1, obj2)
    return rect_overlapping(obj1.x, obj1.y, obj1.x+width, obj1.y+height, obj2.x, obj2.y, obj2.x+width, obj2.y+height)
end


__gfx__
000000000000b000000100000000d000000000007777777700000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000b300000012000000d600009a9aa007666666500000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700094b39400cc12c8004ad64a49aa9aaa07677776500000000000000000000000000000000000000000000000000000000000000000000000000000000
000770009499499488cc88c844a4a4aa9a9aaaa07676656500000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700094999499c8ccc8cc4aa4aa449a9aaaa07676656500000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070094999499c8ccc8cc4a444a449aa9aaa07655556500000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000094999499c88cc8cc4a44aa4409a9aa007666666500000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000949499008cc88c00a44a440000000006555555500000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
011000001b0501e0501e0501605016050171501a1501c1501f100181001010012300183001b3001e300173001230013300193001c30018300143001330011400114001140012400194001d400184001340007400
001000000000024050220501f0501b050190501605013050120500f0500e0500c0500b0500a05009050090500a0500a0500b0500b0500c0500d0500e0500e050000000e0500e050000000e0500e050000000e050
