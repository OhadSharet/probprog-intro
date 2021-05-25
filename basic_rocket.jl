### A Pluto.jl notebook ###
# v0.14.0

using Markdown
using InteractiveUtils

# ╔═╡ 4b2f66ce-af34-11eb-187a-13e88b091642
using Turing, StatsPlots, Random

# ╔═╡ ecd0125d-38a0-4d59-a5d8-f1ba8f7768a3
function rocket_lunch(v0,angle,dt=1)
	c=0
    vy = v0 * sin(angle)
    vx = v0 * cos(angle)
    x = 0
    y = 0
    gravity = 10

    while y>=0
      wind = rand(Normal(0,0.1))
      x = x+(vx+wind)*dt # - (c*MathConstants.e^-y)*dt
      y = y+vy*dt
      vy = vy-gravity*dt
    end
     return x
   end

# ╔═╡ 2039f650-4b48-4e3f-9445-b3a1fdf37639

@model function model(L, dt)
     v0 ~Exponential(1/0.02)
     angle ~ Uniform(0,pi/2)
     x = rocket_lunch(v0,angle,1)
	 Turing.acclogp!(_varinfo, (x-L)^2/100000)
end


# ╔═╡ ac45f025-b0bf-459b-932b-b96856c05023
histogram([rocket_lunch(110, 1.1, 1) for i in 1:1000])

# ╔═╡ 3d510337-2fc8-4768-bbea-4f3e83cee127
begin
	iterations = 10000
	
	ϵ = 0.5
	τ = 5
	
	chain = sample(model(1000,1), HMC(ϵ, τ), iterations)
	#histogram(chain)
	histogram2d(chain[:angle],chain[:v0],nbins=200)
end

# ╔═╡ 504d9516-c9c9-4a44-bb6d-b13c1506a37d
plot(chain)


# ╔═╡ Cell order:
# ╠═4b2f66ce-af34-11eb-187a-13e88b091642
# ╠═ecd0125d-38a0-4d59-a5d8-f1ba8f7768a3
# ╠═2039f650-4b48-4e3f-9445-b3a1fdf37639
# ╠═ac45f025-b0bf-459b-932b-b96856c05023
# ╠═3d510337-2fc8-4768-bbea-4f3e83cee127
# ╠═504d9516-c9c9-4a44-bb6d-b13c1506a37d
