--[[  leap.lua ]]
require('leap').add_default_mappings()

-- overrides
require ('leap').opts.special_keys = {
  next_target = {'<enter>', '>',},    -- drop ';'
  prev_target = {'<tab>', '<'},       -- drop ','
}

