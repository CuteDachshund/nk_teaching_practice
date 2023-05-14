# 電車を加速度運動させることを考える

# mutable struct Train
#     len::Float64
#     hight::Float64
#     x::Float64
#     vel::Float64
#     accs::Float64
#     t::Float64
#     xhis::Array{Float64,1}
#     velhis::Array{Float64,1}
#     accshis::Array{Float64,1}
#     timehis::Array{Float64,1}
#     function Train(accs;len=20,hight=10,x=0,vel=0,t=0)
#         xhis = Float64[]
#         velhis= Float64[]
#         timehis=Float64[]
#         accshis=Float64[]
#         timehis=Float64[]
#         push!(xhis,x)
#         push!(velhis,vel)
#         push!(accshis,accs)
#         push!(timehis,0)
#         return new(len,hight,x,vel,accs,t,xhis,velhis,accshis,timehis)
#     end
# end

mutable struct Train
    len::Float64
    hight::Float64
    x::Float64
    vel::Float64
    accs::Float64
    t::Float64
    l::Float64 # 振り子の長さ
    theta::Float64  #振り子の水平からの角度
    bx::Float64 # 振り子のx座標
    by::Float64 # 振り子のy座標
    xhis::Array{Float64,1}
    velhis::Array{Float64,1}
    accshis::Array{Float64,1}
    timehis::Array{Float64,1}
    function Train(accs;len=20,hight=10,x=0,vel=0,t=0,l=10)
        xhis = Float64[]
        velhis= Float64[]
        timehis=Float64[]
        accshis=Float64[]
        timehis=Float64[]
        bx=Float64
        by=Float64
        theta=Float64
        bx = x
        by = hight-l
        theta=0
        push!(xhis,x)
        push!(velhis,vel)
        push!(accshis,accs)
        push!(timehis,0)
        return new(len,hight,x,vel,accs,t,l,theta,bx,by,xhis,velhis,accshis,timehis)
    end
end

# function update!(train::Train;dt=1/20) # trainの等加速度運動を時間発展させる
#     x=train.x 
#     v=train.vel 
#     a=train.accs 
#     t=train.t 
#     newx = x + v*dt
#     newv = v + a*dt
#     newt = t + dt
#     train.x  =newx#更新
#     train.vel = newv
#     train.accs = a
#     train.t =newt
#     push!(train.xhis,newx)
#     push!(train.velhis,newv)
#     push!(train.timehis,newt)
#     push!(train.accshis,a)
# end

function update!(train::Train;dt=1/20) # trainの等加速度運動を時間発展させる
    x=train.x 
    v=train.vel 
    a=train.accs 
    t=train.t 
    newx = x + v*dt
    newv = v + a*dt
    newt = t + dt
    train.x  =newx#更新
    train.vel = newv
    train.accs = a
    train.t =newt
    push!(train.xhis,newx)
    push!(train.velhis,newv)
    push!(train.timehis,newt)
    push!(train.accshis,a)
end

function show(train::Train)
    l = train.len
    h = train.hight
    x= train.x
    l=train.l
    v = train.vel
    a = train.accs
    t = train.t
    lens=range(0,l/2,step=0.1)
    heigts=range(0,h/2,step=0.1)
    # plot(x.+lens,0.5 .+0 .*lens,color=:blue,xlims=(-10,100),ylims=(0,20),label="t=$(t)",aspectratio=1)
    plot(x.+lens,0.5 .+0 .*lens,color=:blue,xlims=(-10,100),ylims=(0,20),label="",aspectratio=1)
    plot!(x.-lens,0.5 .+0 .*lens,color=:blue,label="")
    plot!(x.-lens,h .+0 .*lens,color=:blue,label="")
    plot!(x.+lens,h .+0 .*lens,color=:blue,label="")
    plot!(0*heigts .+(x+l/2),heigts,color=:blue,label="") # 縦の壁を描く
    plot!(0*heigts .+(x+l/2),2*heigts,color=:blue,label="") # 縦の壁を描く
    plot!(0*heigts .+(x-l/2),heigts,color=:blue,label="") # 縦の壁を描く
    plot!(0*heigts .+(x-l/2),2*heigts,color=:blue,label="") # 縦の壁を描く
    
end