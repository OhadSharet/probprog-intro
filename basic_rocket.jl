### A Pluto.jl notebook ###
# v0.14.0

using Markdown
using InteractiveUtils

# ╔═╡ 4b2f66ce-af34-11eb-187a-13e88b091642
using Turing, StatsPlots, Random

# ╔═╡ ecd0125d-38a0-4d59-a5d8-f1ba8f7768a3
function rocket_lunch(v0,angle,dt=1)
	c=5
    vy = v0 * sin(angle)
    vx = v0 * cos(angle)
    x = 0
    y = 0
    gravity = 10

    while y>0
      wind = rand(Normal(0,5))
      x = x+(vx+wind)*dt - (c*MathConstants.e^-y)*dt
      y = y+vy*dt
      vy = vy-s*dt
    end
     return x
   end

# ╔═╡ 2039f650-4b48-4e3f-9445-b3a1fdf37639

@model function model(L, dt)
     #v0 ~Normal(110,7) #TODO: try and cange that to unifom desrbiotion
     v0 ~Exponential(L)
     angle ~ Uniform(0,pi/2)
     x = rocket_lunch(v0,angle,1)
     x~Normal(L,1)
end


# ╔═╡ 64b8b910-bb17-47a9-93c1-d7d9e921fd9d
begin
	iterations = 100000
	
	ϵ = 0.05
	τ = 10
	
	chain = sample(model(1000,1), HMC(ϵ, τ), iterations)
	#histogram(chain)
	histogram2d(chain[:angle],chain[:v0],nbins=200)
end

# ╔═╡ Cell order:
# ╠═4b2f66ce-af34-11eb-187a-13e88b091642
# ╠═ecd0125d-38a0-4d59-a5d8-f1ba8f7768a3
# ╠═2039f650-4b48-4e3f-9445-b3a1fdf37639
# ╠═64b8b910-bb17-47a9-93c1-d7d9e921fd9d
