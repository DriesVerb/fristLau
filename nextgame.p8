pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
local player
local score
local coins

function _init()
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
                spr(1, self.x, self.y)
        end,
        check_for_collision = function (self, coin)
                            -- hit detectino top and bottom
                local top = self.y
                local bottom = self.y+self.height
                -- setting up condition
                if top<coin.y and coin.y<bottom then
                    self.is_horizontal_align = true
                else 
                    self.is_horizontal_align = false
                end
                -- hit detection left and right
                local left=self.x
                local right=self.x+self.width
                -- setting up conditional
                if left<coin.x and coin.x<right then
                    self.is_vertical_align=true
                else
                    self.is_vertical_align=false
                end
                -- collect the coin
                if self.is_vertical_align and self.is_horizontal_align and not coin.is_collected then
                    coin.is_collected = true
                    score+=1
                end
        end
    }
    coins = {
        make_coin(10,10),
        make_coin(40,20),
        make_coin(90,70),
        make_coin(50,10),
        make_coin(80,90),
    }

    
end

function _update()
player:update();
local coin
for coin in all(coins) do 
    coin:update()
    player:check_for_collision(coin)
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

end

function make_coin(x,y)
    local coin = {
        x=x,
        y=y,
        is_collected=false,
        update=function(self)
            
        end,
        draw=function(self)
            if not self.is_collected then 
                spr(4, self.x-3, self.y-4)
                pset(self.x, self.y, 12)
            end
            
        end

    }
    return coin

end


__gfx__
000000000000b000000100000000d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000b300000012000000d600009a9aa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700094b39400cc12c8004ad64a49aa9aaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770009499499488cc88c844a4a4aa9a9aaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700094999499c8ccc8cc4aa4aa449a9aaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070094999499c8ccc8cc4a444a449aa9aaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000094999499c88cc8cc4a44aa4409a9aa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000949499008cc88c00a44a440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
011000001b0501e0501e0501605016050171501a1501c1501f100181001010012300183001b3001e300173001230013300193001c30018300143001330011400114001140012400194001d400184001340007400
001000000000024050220501f0501b050190501605013050120500f0500e0500c0500b0500a05009050090500a0500a0500b0500b0500c0500d0500e0500e050000000e0500e050000000e0500e050000000e050
