using Turing, StatsPlots, Random
function rocket_lunch(v0,angle)
    vy = v0 * sin(angle)
    vx = v0 * cos(angle)
    x = 0
    y = 0
    gravity = 10

    while y>0
      wind = rand(Normal(0,5))#TODO:check
      x = x+wind+vx
      y = y+vy
      vy = vy-gravity
    end
     return x
   end

 @model function model(data)
   #v0 ~Normal(110,7) #TODO: try and cange that to unifom desrbiotion
   v0 ~Uniform(60,150)
   angle ~ Normal(1.1,0.1)
   for tup in data
   x = rocket_lunch(tup[1], tup[2])
   if(900<x<1100) # TODO: ask David how do it give mor wheight to X that is closer to 1000 then others
     tup[1]~Normal(v0,20)
     tup[2]~Normal(angle,0.2)
     end
   end
  #return [v0,angle]
  end

  data = []
  for n in 1:100
      push!(data,[rand(Normal(110,7)),rand(Normal(1.1,0.1))])
  end

  #TODO: ask David what are thos variabels
  iterations = 10000
  ϵ = 0.05
  τ = 10

  chain = sample(model(data), HMC(ϵ, τ), iterations)
  histogram(chain)#TODO: how can i crate plot with 2 parameters
