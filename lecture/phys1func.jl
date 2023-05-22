using Plots
using Flux

function calc_circular(om,R) # 円運動の軌道を計算する
    T = 2*π/om
    fx(t) = R*cos(om*t) # x,y成分の軌道の時間の式 
    fy(t) = R*sin(om*t)
    vx(t) = fx'(t) #速度の式を軌道の式からつくる
    vy(t) = fy'(t)
    ax(t) = vx'(t)
    ay(t) = vy'(t)
    ts = range(0,T,step=1/20) # 時間
    xs = fx.(ts)
    ys = fy.(ts)
    xvs= vx.(ts)
    yvs= vy.(ts) # 軌道・速度の時系列データを計算
    xas= ax.(ts)
    yas= ay.(ts) # 軌道・速度の時系列データを計算
    ts=round.(ts,digits=1) # 時間配列を表示に適した桁に修正
    return ts,xs,ys,xvs,yvs,xas,yas
end

function gen_circularanim(data1;xvel=false,yvel=false,trj=false,ang=false,vel=false,accs=false,strobe=false) # 円運動の動画を作る
    ts = data1[1]
    xs = data1[2]
    ys = data1[3]
    xvs=data1[4]
    yvs=data1[5]
    xas=data1[6]
    yas=data1[7]
    R = xs[1]
    theta = range(0,2π,step=0.01)#　質点描画
    r = 5 # 質点の半径
    anim = Animation()
    for i in 1:length(ts)
        plt=plot(xs[i] .+r*cos.(theta),ys[i].+r*sin.(theta),aspectratio=1,xlims=(-100,100),ylims=(-100,100),label="t=$(ts[i])",xlabel="x",ylabel="y",linecolor=:blue,linewidth=3) # 質点のプロット
        if strobe == true
            for j in 1:i 
                plt=plot!(xs[j] .+r*cos.(theta),ys[j].+r*sin.(theta),aspectratio=1,xlims=(-100,100),ylims=(-100,100),label="",xlabel="x",ylabel="y",linecolor=:blue,linewidth=3)
            end
        end
        if trj==true
            plt=plot!(xs[1:i],ys[1:i],legend = :bottomleft,foreground_color_legend = :white,alpha=0.2,linewidth=3) # 軌道のプロット
        end
        if vel==true
            plt=plot!([xs[i],xs[i]+xvs[i]], [ys[i],ys[i]+yvs[i]], arrow = arrow(),label="v",linewidth=3) # 速度のプロット
        end
        if xvel==true
            plt=plot!([xs[i],xs[i]], [ys[i],ys[i]+yvs[i]], arrow = arrow(),label="vy",linewidth=3) # 速度のx成分のプロット
        end
        if yvel==true
            plt=plot!([xs[i],xs[i]+xvs[i]], [ys[i],ys[i]], arrow = arrow(),label="vx",linewidth=3) # 速度のy成分のプロット
        end
        if ang==true
            plt=plot!([0,xs[i]],[0,ys[i]],label="",linecolor=:blue,alpha=0.2,linewidth=3) # 回転中心と質点を結ぶ直線
            plt=plot!([0,R],[0,0],label="",linecolor=:blue ,alpha=0.2,linewidth=3) # 回転中心と質点を結ぶ直線
        end
        if accs==true
            plt=plot!([xs[i],xs[i]+xas[i]], [ys[i],ys[i]+yas[i]], arrow = arrow(),label="a",linewidth=3)
        end
        frame(anim,plt)
    end
    gif(anim,fps=20)
end

function gen_circularsnap(data1,j;xvel=false,yvel=false,trj=false,ang=false,vel=false)
    ts = data1[1]
    xs = data1[2]
    ys = data1[3]
    xvs=data1[4]
    yvs=data1[5]
    R = xs[1]
    theta = range(0,2π,step=0.01)#　質点描画
    r = 5 # 質点の半径
    i = j
    plt=plot(xs[i] .+r*cos.(theta),ys[i].+r*sin.(theta),aspectratio=1,xlims=(-100,100),ylims=(-100,100),label="",xlabel="x",ylabel="y",linecolor=:blue,linewidth=5) # 質点のプロット
    if trj==true
        plt=plot!(xs[1:i],ys[1:i],label="t=$(ts[i])",legend = :bottomleft,foreground_color_legend = :white,alpha=0.2,linewidth=5) # 軌道のプロット
    end
    if vel==true
        plt=plot!([xs[i],xs[i]+xvs[i]], [ys[i],ys[i]+yvs[i]], arrow = arrow(),label="v",linewidth=5) # 速度のプロット
    end
    if xvel==true
        plt=plot!([xs[i],xs[i]], [ys[i],ys[i]+yvs[i]], arrow = arrow(),label="vy",linewidth=5) # 速度のx成分のプロット
    end
    if yvel==true
        plt=plot!([xs[i],xs[i]+xvs[i]], [ys[i],ys[i]], arrow = arrow(),label="vx",linewidth=5) # 速度のy成分のプロット
    end
    if ang==true
        plt=plot!([0,xs[i]],[0,ys[i]],label="",linecolor=:blue,alpha=0.2,linewidth=5) # 回転中心と質点を結ぶ直線
        plt=plot!([0,R],[0,0],label="",linecolor=:blue ,alpha=0.2,linewidth=5) # 回転中心と質点を結ぶ直線
    end
end

function gen_circularsnap!(data1,j;xvel=false,yvel=false,trj=false,ang=false,vel=false)
    ts = data1[1]
    xs = data1[2]
    ys = data1[3]
    xvs=data1[4]
    yvs=data1[5]
    R = xs[1]
    theta = range(0,2π,step=0.01)#　質点描画
    r = 5 # 質点の半径
    i = j
    plt=plot!(xs[i] .+r*cos.(theta),ys[i].+r*sin.(theta),aspectratio=1,xlims=(-100,100),ylims=(-100,100),label="",xlabel="x",ylabel="y",linecolor=:blue,linewidth=5) # 質点のプロット
    if trj==true
        plt=plot!(xs[1:i],ys[1:i],label="t=$(ts[i])",legend = :bottomleft,foreground_color_legend = :white,alpha=0.2,linewidth=5) # 軌道のプロット
    end
    if vel==true
        plt=plot!([xs[i],xs[i]+xvs[i]], [ys[i],ys[i]+yvs[i]], arrow = arrow(),label="v",linewidth=5) # 速度のプロット
    end
    if xvel==true
        plt=plot!([xs[i],xs[i]], [ys[i],ys[i]+yvs[i]], arrow = arrow(),label="vy",linewidth=5) # 速度のx成分のプロット
    end
    if yvel==true
        plt=plot!([xs[i],xs[i]+xvs[i]], [ys[i],ys[i]], arrow = arrow(),label="vx",linewidth=5) # 速度のy成分のプロット
    end
    if ang==true
        plt=plot!([0,xs[i]],[0,ys[i]],label="",linecolor=:blue,alpha=0.2,linewidth=5) # 回転中心と質点を結ぶ直線
        plt=plot!([0,R],[0,0],label="",linecolor=:blue ,alpha=0.2,linewidth=5) # 回転中心と質点を結ぶ直線
    end
end

function phys1plot1()
    anim=Animation()
    for n in 20:-1:1
        plt=gen_circularsnap(data1,n,trj=true,ang=true)
        plt=plot!([50,(50*cos(n/20)-50)/(n/20)+50], [0,(50*sin(n/20))/(n/20)], arrow = arrow(),label="v",linewidth=5)
        frame(anim,plt)
    end
    gif(anim,fps=20)
end

function phys1plot2()
    plot(aspectratio=1)
    plot!([0,data1[4][20]], [0,data1[5][20]], arrow = arrow(),label="",linecolor=:green,alpha=0.2,linewidth=5)
    plot!([0,data1[4][1]], [0,data1[5][1]], arrow = arrow(),label="",linecolor=:red,alpha=0.2,linewidth=5)
    theta = range(0,2π,step=0.01)
    plot!(50*cos.(theta),50*sin.(theta),linecolor=:blue,label="",alpha=0.2,linewidth=5)
    plot!([data1[4][1],data1[4][20]], [data1[5][1],data1[5][20]], arrow = arrow(),label="",linecolor=:black,linewidth=5)
end

function gen_circularanim(data1,data2;xvel=false,yvel=false,trj=false,ang=false,vel=false,accs=false,strobe=false) # 円運動の動画を作る
    ts = data1[1]
    xs = data1[2]
    ys = data1[3]
    xvs=data1[4]
    yvs=data1[5]
    xas=data1[6]
    yas=data1[7]
    R = xs[1]
    ts2 = data2[1]
    xs2 = data2[2]
    ys2 = data2[3]
    xvs2=data2[4]
    yvs2=data2[5]
    xas2=data2[6]
    yas2=data2[7]
    R2= xs2[1]
    theta = range(0,2π,step=0.01)#　質点描画
    r = 5 # 質点の半径
    anim = Animation()
    for i in 1:length(ts)
        plt=plot(xs[i] .+r*cos.(theta),ys[i].+r*sin.(theta),aspectratio=1,xlims=(-100,100),ylims=(-100,100),label="",xlabel="x",ylabel="y",linecolor=:blue,linewidth=3) # 質点のプロット
        plt=plot!(xs2[i] .+r*cos.(theta),ys2[i].+r*sin.(theta),aspectratio=1,xlims=(-100,100),ylims=(-100,100),label="",xlabel="x",ylabel="y",linecolor=:blue,linewidth=3) # 質点のプロット
        if strobe == true
            for j in 1:i 
                plt=plot!(xs[j] .+r*cos.(theta),ys[j].+r*sin.(theta),aspectratio=1,xlims=(-100,100),ylims=(-100,100),label="",xlabel="x",ylabel="y",linecolor=:blue,linewidth=3)
                plt=plot!(xs2[j] .+r*cos.(theta),ys2[j].+r*sin.(theta),aspectratio=1,xlims=(-100,100),ylims=(-100,100),label="",xlabel="x",ylabel="y",linecolor=:blue,linewidth=3)
            end
        end
        if trj==true
            plt=plot!(xs[1:i],ys[1:i],label="t=$(ts[i])",legend = :bottomleft,foreground_color_legend = :white,alpha=0.2,linewidth=3) # 軌道のプロット
        end
        if vel==true
            plt=plot!([xs[i],xs[i]+xvs[i]], [ys[i],ys[i]+yvs[i]], arrow = arrow(),label="v",linewidth=3) # 速度のプロット
        end
        if xvel==true
            plt=plot!([xs[i],xs[i]], [ys[i],ys[i]+yvs[i]], arrow = arrow(),label="vy",linewidth=3) # 速度のx成分のプロット
        end
        if yvel==true
            plt=plot!([xs[i],xs[i]+xvs[i]], [ys[i],ys[i]], arrow = arrow(),label="vx",linewidth=3) # 速度のy成分のプロット
        end
        if ang==true
            plt=plot!([0,xs[i]],[0,ys[i]],label="",linecolor=:blue,alpha=0.2,linewidth=3) # 回転中心と質点を結ぶ直線
            plt=plot!([0,R],[0,0],label="",linecolor=:blue ,alpha=0.2,linewidth=3) # 回転中心と質点を結ぶ直線
            plt=plot!([0,xs2[i]],[0,ys2[i]],label="",linecolor=:blue,alpha=0.2,linewidth=3) # 回転中心と質点を結ぶ直線
            plt=plot!([0,R2],[0,0],label="",linecolor=:blue ,alpha=0.2,linewidth=3) # 回転中心と質点を結ぶ直線
        end
        if accs==true
            plt=plot!([xs[i],xs[i]+xas[i]], [ys[i],ys[i]+yas[i]], arrow = arrow(),label="a",linewidth=3)
        end
        frame(anim,plt)
    end
    gif(anim,fps=20)
end


function gen_circularanim_mp4(data1,data2;xvel=false,yvel=false,trj=false,ang=false,vel=false,accs=false,strobe=false) # 円運動の動画を作る
    ts = data1[1]
    xs = data1[2]
    ys = data1[3]
    xvs=data1[4]
    yvs=data1[5]
    xas=data1[6]
    yas=data1[7]
    R = xs[1]
    ts2 = data2[1]
    xs2 = data2[2]
    ys2 = data2[3]
    xvs2=data2[4]
    yvs2=data2[5]
    xas2=data2[6]
    yas2=data2[7]
    R2= xs2[1]
    theta = range(0,2π,step=0.01)#　質点描画
    r = 5 # 質点の半径
    anim = Animation()
    for i in 1:length(ts2)
        plt=plot(xs[i] .+r*cos.(theta),ys[i].+r*sin.(theta),aspectratio=1,xlims=(-100,100),ylims=(-100,100),label="",xlabel="x",ylabel="y",linecolor=:blue,linewidth=3) # 質点のプロット
        plt=plot!(xs2[i] .+r*cos.(theta),ys2[i].+r*sin.(theta),aspectratio=1,xlims=(-100,100),ylims=(-100,100),label="",xlabel="x",ylabel="y",linecolor=:blue,linewidth=3) # 質点のプロット
        if strobe == true
            for j in 1:i 
                plt=plot!(xs[j] .+r*cos.(theta),ys[j].+r*sin.(theta),aspectratio=1,xlims=(-100,100),ylims=(-100,100),label="",xlabel="x",ylabel="y",linecolor=:blue,linewidth=3)
                plt=plot!(xs2[j] .+r*cos.(theta),ys2[j].+r*sin.(theta),aspectratio=1,xlims=(-100,100),ylims=(-100,100),label="",xlabel="x",ylabel="y",linecolor=:blue,linewidth=3)
            end
        end
        if trj==true
            plt=plot!(xs[1:i],ys[1:i],label="t=$(ts[i])",legend = :bottomleft,foreground_color_legend = :white,alpha=0.2,linewidth=3) # 軌道のプロット
        end
        if vel==true
            plt=plot!([xs[i],xs[i]+xvs[i]], [ys[i],ys[i]+yvs[i]], arrow = arrow(),label="v",linewidth=3) # 速度のプロット
        end
        if xvel==true
            plt=plot!([xs[i],xs[i]], [ys[i],ys[i]+yvs[i]], arrow = arrow(),label="vy",linewidth=3) # 速度のx成分のプロット
        end
        if yvel==true
            plt=plot!([xs[i],xs[i]+xvs[i]], [ys[i],ys[i]], arrow = arrow(),label="vx",linewidth=3) # 速度のy成分のプロット
        end
        if ang==true
            plt=plot!([0,xs[i]],[0,ys[i]],label="",linecolor=:blue,alpha=0.2,linewidth=3) # 回転中心と質点を結ぶ直線
            plt=plot!([0,R],[0,0],label="",linecolor=:blue ,alpha=0.2,linewidth=3) # 回転中心と質点を結ぶ直線
            plt=plot!([0,xs2[i]],[0,ys2[i]],label="",linecolor=:blue,alpha=0.2,linewidth=3) # 回転中心と質点を結ぶ直線
            plt=plot!([0,R2],[0,0],label="",linecolor=:blue ,alpha=0.2,linewidth=3) # 回転中心と質点を結ぶ直線
        end
        if accs==true
            plt=plot!([xs[i],xs[i]+xas[i]], [ys[i],ys[i]+yas[i]], arrow = arrow(),label="a",linewidth=3)
        end
        frame(anim,plt)
    end
    gif(anim,"ss.mp4",fps=20)
end



function gen_circularanim_mp4(data1;xvel=false,yvel=false,trj=false,ang=false,vel=false,accs=false,strobe=false) # 円運動の動画を作る
    ts = data1[1]
    xs = data1[2]
    ys = data1[3]
    xvs=data1[4]
    yvs=data1[5]
    xas=data1[6]
    yas=data1[7]
    R = xs[1]
    theta = range(0,2π,step=0.01)#　質点描画
    r = 5 # 質点の半径
    anim = Animation()
    for i in 1:length(ts)
        plt=plot(xs[i] .+r*cos.(theta),ys[i].+r*sin.(theta),aspectratio=1,xlims=(-100,100),ylims=(-100,100),label="",xlabel="x",ylabel="y",linecolor=:blue,linewidth=3) # 質点のプロット
        if strobe == true
            for j in 1:i 
                plt=plot!(xs[j] .+r*cos.(theta),ys[j].+r*sin.(theta),aspectratio=1,xlims=(-100,100),ylims=(-100,100),label="",xlabel="x",ylabel="y",linecolor=:blue,linewidth=3)
            end
        end
        if trj==true
            plt=plot!(xs[1:i],ys[1:i],label="t=$(ts[i])",legend = :bottomleft,foreground_color_legend = :white,alpha=0.2,linewidth=3) # 軌道のプロット
        end
        if vel==true
            plt=plot!([xs[i],xs[i]+xvs[i]], [ys[i],ys[i]+yvs[i]], arrow = arrow(),label="v",linewidth=3) # 速度のプロット
        end
        if xvel==true
            plt=plot!([xs[i],xs[i]], [ys[i],ys[i]+yvs[i]], arrow = arrow(),label="vy",linewidth=3) # 速度のx成分のプロット
        end
        if yvel==true
            plt=plot!([xs[i],xs[i]+xvs[i]], [ys[i],ys[i]], arrow = arrow(),label="vx",linewidth=3) # 速度のy成分のプロット
        end
        if ang==true
            plt=plot!([0,xs[i]],[0,ys[i]],label="",linecolor=:blue,alpha=0.2,linewidth=3) # 回転中心と質点を結ぶ直線
            plt=plot!([0,R],[0,0],label="",linecolor=:blue ,alpha=0.2,linewidth=3) # 回転中心と質点を結ぶ直線
        end
        if accs==true
            plt=plot!([xs[i],xs[i]+xas[i]], [ys[i],ys[i]+yas[i]], arrow = arrow(),label="a",linewidth=3)
        end
        frame(anim,plt)
    end
    gif(anim,"anim.mp4",fps=20)
end