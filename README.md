# Meshname
Gem, which provides conversion and DNS resolution functions for the Meshname protocol (see https://github.com/zhoreeq/meshname)

Depends on Base32

## Example
```
Meshname.getname IPAddr.new("215:15c:84e0:8dd5:7590:bfcd:61cf:cff7") => "aikqcxee4cg5k5mqx7gwdt6p64"
"#{Meshname.getname IPAddr.new("215:15c:84e0:8dd5:7590:bfcd:61cf:cff7")}.meship" => "aikqcxee4cg5k5mqx7gwdt6p64.meship"


Meshname.getip "aikqcxee4cg5k5mqx7gwdt6p64" => #<IPAddr: IPv6:0215:015c:84e0:8dd5:7590:bfcd:61cf:cff7/ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff>
Meshname.getip("aikqcxee4cg5k5mqx7gwdt6p64").to_s => "215:15c:84e0:8dd5:7590:bfcd:61cf:cff7"

Meshname.resolv("aikqcxee4cg5k5mqx7gwdt6p64.meship") => [#<IPAddr: IPv6:0215:015c:84e0:8dd5:7590:bfcd:61cf:cff7/ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff>]
Meshname.resolv("aikqcxee4cg5k5mqx7gwdt6p64.meship")[0].to_s => "215:15c:84e0:8dd5:7590:bfcd:61cf:cff7"

Meshname.resolv("aikqcxee4cg5k5mqx7gwdt6p64.meshname") => [#<IPAddr: IPv6:0215:015c:84e0:8dd5:7590:bfcd:61cf:cff7/ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff>]
Meshname.resolv("aikqcxee4cg5k5mqx7gwdt6p64.meshname")[0].to_s => "215:15c:84e0:8dd5:7590:bfcd:61cf:cff7"
```

## Meshname
Read more on https://github.com/zhoreeq/meshname and https://github.com/zhoreeq/meshname/blob/master/protocol.md
